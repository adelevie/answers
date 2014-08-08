# include associated recipes
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "chef-solo-search"


# install required libs for memcached and postgresql
['libsasl2-dev', 'libpq-dev', 'ruby-dev'].each { |pkg| package pkg }


# create swap space
swap_file '/mnt/swap' do
	size 4096
end


# setup db users using encrypted data bags
db_config = Chef::EncryptedDataBagItem.load("config", "db")

puts "Adding DB Users:"
db_config["users"].each do |db_user|
	puts "  added user '#{db_user['username']}' from databag"
	pg_user db_user['username'] do
	  privileges superuser: false, createdb: false, login: true
	  password db_user['password']
	end
end if db_config["users"]
puts "\n\n"


# install ruby
rbenv_ruby node[:answers][:ruby][:version] do
	global true
end


# install bundler and passegner systemwide
['bundler', 'passenger'].each do |cmd|
	rbenv_gem cmd do; ruby_version node[:answers][:ruby][:version] end
end


# setup secret files (db.yml, app secrets, etc.)
puts "Adding template files generated from encrypted data bags:"
env_config = Chef::EncryptedDataBagItem.load("config", "env")

template '/home/vagrant/answers/.env' do
	variables env: env_config 
end
puts "* generated .env"

puts Dir.pwd
template '/home/vagrant/answers/config/database.yml' do
	variables password: db_config['users'][0]['password']
end
puts '* generated config/database.yml'


# bundle gems, migrate db
['bundle install', 'bundle exec rake db:migrate'].each do |cmd|
	rbenv_execute cmd do
		cwd '/home/vagrant/answers'
		retries 2
	end 
end
puts '* bundle gems, migrate db'


# reindex elasticsearch
rbenv_execute 'bundle exec rake searchkick:reindex:all' do
	cwd '/home/vagrant/answers'
	retries 2
	notifies :restart, "service[elasticsearch]", :immediately
end
puts '* reindex elasticsearch'

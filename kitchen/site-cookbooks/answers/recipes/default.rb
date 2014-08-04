# install required libs for memcached and postgresql
['libsasl2-dev', 'libpq-dev', 'ruby-dev'].each { |pkg| package pkg }

# install ruby
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "chef-solo-search"

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

rbenv_ruby node[:answers][:ruby][:version] do
	global true
end

# install bundler and passegner systemwide
['bundler', 'passenger'].each do |cmd|
	rbenv_gem cmd do; ruby_version node[:answers][:ruby][:version] end
end

# bundle gems, migrate db, reindex elasticsearch
['bundle install', 'bundle exec rake db:migrate', 'bundle exec rake searchkick:reindex:all'].each do |cmd|
	rbenv_execute cmd do; cwd '/home/vagrant/answers' end 
end

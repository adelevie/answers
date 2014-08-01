# install required libs for memcached
package "libsasl2-dev"
package 'ruby-dev'

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

rbenv_ruby '2.1.2' do
	global true
end

rbenv_gem "bundler" do
  ruby_version '2.1.2'
end

rbenv_gem "passenger" do
  ruby_version '2.1.2'
end

# bundle gems, migrate db, reindex elasticsearch
['bundle install', 'bundle exec rake db:migrate', 'bundle exec rake searchkick:reindex:all'].each do |cmd|
	rbenv_execute cmd do; cwd '/home/vagrant/answers' end 
end

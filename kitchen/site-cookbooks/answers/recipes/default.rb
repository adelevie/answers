# install required libs for memcached
package "libsasl2-dev"
package 'ruby-dev'

# install ruby
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "rbenv::rbenv_vars"

rbenv_ruby '2.1.2' do
	force true
	global true
end

rbenv_gem "bundler" do
  ruby_version '2.1.2'
end

rbenv_gem "passenger" do
  ruby_version '2.1.2'
end

# bundle gems
execute "bundle install" do
	cwd '/home/vagrant/answers'
end

# bundle gems
execute "bundle exec rake db:setup" do
  cwd '/home/vagrant/answers'
  environment ({ "USER" => 'answers' })
end

# add user to do db, create db

# run migrate (only if flag set) and seed data (only if flag set)

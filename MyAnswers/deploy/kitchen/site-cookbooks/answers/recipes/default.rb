# include associated recipes
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "chef-solo-search"


# install required libs for memcached and postgresql
['libsasl2-dev', 'libpq-dev', 'ruby-dev'].each { |pkg| package pkg }


# setup db users using encrypted data bags
db_config = Chef::EncryptedDataBagItem.load("config", "db")

db_config["users"].each do |db_user|
	pg_user db_user['username'] do
	  privileges superuser: false, createdb: true, login: true
	  password db_user['password']
	end
end if db_config["users"]


# install ruby
rbenv_ruby node[:answers][:ruby][:version] do
	global true
end


# install bundler and passegner systemwide
['bundler', 'passenger'].each do |cmd|
	rbenv_gem cmd do; ruby_version node[:answers][:ruby][:version] end
end


# setup secret files (db.yml, app secrets, etc.)
env_config = Chef::EncryptedDataBagItem.load("config", "env")

directory "#{node[:answers][:rails][:deploy_to]}/shared/config" do
	owner node[:answers][:rails][:deploy_user]
	recursive true
end

if node[:answers][:rails][:clone]

	current_release = `date "+%Y%m%d%H%M"`.chomp

	directory "#{node[:answers][:rails][:deploy_to]}/releases" do
		owner node[:answers][:rails][:deploy_user]
		recursive true
		not_if { Dir.exists?("#{node[:answers][:rails][:deploy_to]}/current") }
	end

	execute "/usr/bin/git clone https://github.com/18F/answers.git #{node[:answers][:rails][:deploy_to]}/releases/#{current_release}" do
		user node[:answers][:rails][:deploy_user]
		not_if { Dir.exists?("#{node[:answers][:rails][:deploy_to]}/current") }
	end

	# still some sort of error happening here, I had to do this manually to move forward on AWS=
	link "#{node[:answers][:rails][:deploy_to]}/current" do
		owner node[:answers][:rails][:deploy_user]
		not_if { Dir.exists?("#{node[:answers][:rails][:deploy_to]}/current") }
		to "#{node[:answers][:rails][:deploy_to]}/releases/#{current_release}"
	end

end

template "#{node[:answers][:rails][:deploy_to]}/shared/config/.env" do
	owner node[:answers][:rails][:deploy_user]
	variables env: env_config 
end

link "#{node[:answers][:rails][:deploy_to]}/current/.env" do
  to "#{node[:answers][:rails][:deploy_to]}/shared/config/.env"
	owner node[:answers][:rails][:deploy_user]
  not_if { File.exists?("#{node[:answers][:rails][:deploy_to]}/current/.env") }
#  subscribes :run, "link[#{node[:answers][:rails][:deploy_to]}/current]", :delayed
end

template "#{node[:answers][:rails][:deploy_to]}/shared/config/database.yml" do
	owner node[:answers][:rails][:deploy_user]
	variables password: db_config['users'][0]['password']
end

link "#{node[:answers][:rails][:deploy_to]}/current/config/database.yml" do
  owner node[:answers][:rails][:deploy_user]
	to "#{node[:answers][:rails][:deploy_to]}/shared/config/database.yml"
  not_if { File.exists?("#{node[:answers][:rails][:deploy_to]}/current/config/database.yml") }
#  subscribes :run, "link[#{node[:answers][:rails][:deploy_to]}/current]", :delayed
end


# bundle gems, migrate db
['bundle install --system', 'bundle exec rake db:migrate'].each do |cmd|
	rbenv_execute cmd do
		cwd "#{node[:answers][:rails][:deploy_to]}/current"
		environment "RAILS_ENV" => node[:answers][:rails][:env]
		retries 3
		retry_delay 13
	end 
end

# restore perms since the above must be run as root
execute 'chown -R rbenv:rbenv /opt/rbenv'
execute 'chmod -R g+rwx /opt/rbenv'


# use curl to check if the articles index exists by checking for a 200
# respnonse on the index name.  The command will return 0 when the
# index exists (status code 200) and 1 when it does not (status code
# 400)
index_check = "curl -XHEAD -is localhost:9200/articles* | awk '/[2-5][0-9][0-9]/ {if ($2 == 200) print 0; else print $2}'"

# reindex elasticsearch if it has not been done already
# need to make sure this runs after elasticsearch has started
service "elasticsearch" do
	action :start
end

execute "sleep 26"

rbenv_execute 'bundle exec rake searchkick:reindex:all' do
	cwd "#{node[:answers][:rails][:deploy_to]}/current"
	environment "RAILS_ENV" => node[:answers][:rails][:env]
	only_if index_check
	subscribes :run, "gem_package[rwordnet]", :delayed
	subscribes :run, "cookbook_file[/var/lib/wn_s.pl]", :delayed
	subscribes :run, "service[elasticsearch]", :delayed
	retries 3
	retry_delay 30 # may need long delays for ES to fully start.
end

# symlink directory to deploy_user's home dir
link "/home/#{node[:answers][:rails][:deploy_user]}/answers" do
  to "#{node[:answers][:rails][:deploy_to]}/current"
end
#
# Cookbook Name:: rvm
# Recipe:: install

ruby_version = [].tap do |v|
  v << node[:rvm][:ruby][:implementation] if node[:rvm][:ruby][:implementation]
  v << node[:rvm][:ruby][:version] if node[:rvm][:ruby][:version]
  v << node[:rvm][:ruby][:patch_level] if node[:rvm][:ruby][:patch_level]
end * '-'

include_recipe "rvm::default"

bash "installing #{ruby_version}" do
  user "root"
  code "/usr/local/rvm/bin/rvm install #{ruby_version}"
  not_if "/usr/local/rvm/bin/rvm list | grep #{ruby_version}"
end

bash "make #{ruby_version} the default ruby" do
  user node[:rvm][:user] || 'ubuntu'
  code "/usr/local/rvm/bin/rvm use --default #{ruby_version}"
  not_if "/usr/local/rvm/bin/rvm list | grep '=* #{ruby_version}'"
  only_if { node[:rvm][:ruby][:default] }
  notifies :run, resources(:execute => "rvm-cleanup")
end

# set this for compatibilty with other people's recipes
node.default[:languages][:ruby][:ruby_bin] = find_ruby

gem_package "chef" do
  gem_binary "/usr/local/rvm/wrappers/#{ruby_version}@global/gem"
  retries 2
  retry_delay 2
end

# Needed so that chef doesn't freak out if the chef-client service
# isn't present
#service "chef-client"

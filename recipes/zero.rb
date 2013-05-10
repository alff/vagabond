execute 'apt-get update'
package 'build-essential'
gem_package 'chef-zero'

execute 'start chef-zero' do
  command "#{File.join(node[:languages][:ruby][:bin_dir],'chef-zero')} start -H #{node[:ipaddress]} -p 80 &"
  not_if 'netstat -lpt | grep "tcp[[:space:]]" | grep ruby'
  notifies :run, 'bash[disown chef-zero]', :immediately
end

bash 'disown chef-zero' do
  action :nothing
  command 'disown %1'
end

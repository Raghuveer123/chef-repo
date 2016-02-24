# Script to update the Jvm Property values
wsadmin_path = "#{node['wsi']['wsadmin_path']}"
script_lang = "#{node['wsi']['script_lang']}"
was_user = "#{node['wsi']['was_user_id']}"
was_group = "#{node['wsi']['was_group_id']}"
generic_jvm_script_file = "#{node['wsi']['generic_jvm_script_file']}"
cluster_name = "#{node['wsi']['cluster_name']}"
enable_verbose_gc = "#{node['wsi']['enable_verbose_gc']}"
initial_heap_size = "#{node['wsi']['initial_heap_size']}"
maximum_heap_size = "#{node['wsi']['maximum_heap_size']}"
umask = "#{node['wsi']['umask']}"

cookbook_file "#{generic_jvm_script_file}" do
  source 'genericJVM.py'
  owner was_user
  group was_group
  mode '755'
  action :create
end

execute 'jvmproperty' do
        command " #{wsadmin_path}/wsadmin.sh -lang #{script_lang} -f #{generic_jvm_script_file} #{cluster_name} #{enable_verbose_gc} #{initial_heap_size} #{maximum_heap_size} #{umask}"
end

class Chef
  class Platform
    class ResourcePriorityMap
      include Singleton

      def initialize
        load_default_map
      end

      def load_default_map
        require 'chef/resources'

        # MacOSX
        priority :package, Chef::Resource::HomebrewPackage, os: "darwin"
      end

      def priority_map
        require 'chef/node_map'
        @priority_map ||= Chef::NodeMap.new
      end

      def priority(*args)
        priority_map.set(*args)
      end

      def get_priority_map_for_resource(node, resource_name)
        priority_map.get(node, resource_name.to_sym)
      end

      def set_priority_map_for_resource(node, resource_name, priority_array)
        priority resource_name, priority_array, platform: node[:platform]
      end
    end
  end
end

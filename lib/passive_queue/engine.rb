# ================================
# lib/passive_queue/engine.rb
# ================================
module PassiveQueue
  # Rack engine that mounts the PassiveQueue web dashboard in Rails applications
  class Engine
    # Rack call method that delegates to the Web application
    #
    # @param env [Hash] Rack environment hash
    # @return [Array] Rack response triplet [status, headers, body]
    def self.call(env)
      # Strip the mount path to get relative path
      path_info = env['PATH_INFO']
      script_name = env['SCRIPT_NAME']

      # Create new env with adjusted paths for the Web app
      web_env = env.dup
      web_env['PATH_INFO'] = path_info
      web_env['SCRIPT_NAME'] = script_name

      Web.new.call(web_env)
    end
  end
end

# ================================
# Usage in Rails routes.rb:
# ================================
# Rails.application.routes.draw do
#   mount PassiveQueue::Engine => '/passive_queue'
# end

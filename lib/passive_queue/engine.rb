# ================================
# lib/passive_queue/engine.rb  
# ================================
module PassiveQueue
  class Engine
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

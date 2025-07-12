# ================================
# lib/passive_queue/railtie.rb
# ================================
begin
  require "rails"

  module PassiveQueue
    class Railtie < Rails::Railtie
      initializer "passive_queue.configure" do |app|
        ActiveSupport.on_load(:active_job) do
          require "passive_queue/adapter"
        end
      end
    end
  end
rescue LoadError
  # Rails not available, that's fine - we embrace the void
end

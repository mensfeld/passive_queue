begin
  require "active_job"
  require "passive_queue/adapter"

  module ActiveJob
    module QueueAdapters
      class PassiveQueueAdapter < PassiveQueue::Adapter
        # Rails queue adapter integration
        # This allows Rails to find our adapter when configured with:
        # config.active_job.queue_adapter = :passive_queue
      end
    end
  end
rescue LoadError
  # ActiveJob not available, that's fine - we're zen about it
end

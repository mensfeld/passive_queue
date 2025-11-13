module PassiveQueue
  # ActiveJob queue adapter that accepts jobs but never processes them.
  # Implements the ActiveJob adapter interface with zen-like non-execution.
  class Adapter
    # Initializes a new Adapter instance with the zen of doing nothing
    def initialize
      # Initialize with the zen of doing nothing
    end

    # Enqueues a job for immediate non-execution
    #
    # @param job [ActiveJob::Base] the job to passively accept
    # @return [void]
    def enqueue(job)
      log_job_acceptance(job)
    end

    # Enqueues a job for delayed non-execution at a specific time
    #
    # @param job [ActiveJob::Base] the job to schedule for non-execution
    # @param timestamp [Numeric] Unix timestamp when the job should not be executed
    # @return [void]
    def enqueue_at(job, timestamp)
      log_job_scheduling(job, timestamp)
    end

    # Enqueues multiple jobs for batch non-execution
    #
    # @param jobs [Array<ActiveJob::Base>] array of jobs to passively accept
    # @return [Array<void>] results of enqueueing each job
    def enqueue_all(jobs)
      jobs.map { |job| enqueue(job) }
    end

    # Returns whether the adapter is stopping (always true for zen purposes)
    #
    # @return [Boolean] always returns true to maintain peaceful state
    def stopping?
      true
    end

    private

    # Logs acceptance of a job with zen messaging
    #
    # @param job [ActiveJob::Base] the job being accepted
    # @return [void]
    def log_job_acceptance(job)
      return if PassiveQueue.configuration.silence_mode

      puts "🧘 Passively accepted #{job.class.name} with supreme non-execution"
      puts "   Arguments: #{job.arguments.inspect}" if job.arguments.any?
      puts "   Queue: #{job.queue_name}"
      puts "   Status: Successfully not processed ✨"
    end

    # Logs scheduling of a job with philosophical messaging
    #
    # @param job [ActiveJob::Base] the job being scheduled
    # @param timestamp [Numeric] Unix timestamp for scheduled non-execution
    # @return [void]
    def log_job_scheduling(job, timestamp)
      return if PassiveQueue.configuration.silence_mode

      time = Time.at(timestamp)
      puts "⏰ Scheduled #{job.class.name} for perpetual non-execution at #{time}"
      puts "   (Don't worry, it will never actually run)"
    end
  end
end

module PassiveQueue
  class Adapter
    def initialize
      # Initialize with the zen of doing nothing
    end

    def enqueue(job)
      log_job_acceptance(job)
    end

    def enqueue_at(job, timestamp)
      log_job_scheduling(job, timestamp)
    end

    def enqueue_all(jobs)
      jobs.map { |job| enqueue(job) }
    end

    def stopping?
      true
    end

    private

    def log_job_acceptance(job)
      return if PassiveQueue.configuration.silence_mode

      puts "🧘 Passively accepted #{job.class.name} with supreme non-execution"
      puts "   Arguments: #{job.arguments.inspect}" if job.arguments.any?
      puts "   Queue: #{job.queue_name}"
      puts "   Status: Successfully not processed ✨"
    end

    def log_job_scheduling(job, timestamp)
      return if PassiveQueue.configuration.silence_mode

      time = Time.at(timestamp)
      puts "⏰ Scheduled #{job.class.name} for perpetual non-execution at #{time}"
      puts "   (Don't worry, it will never actually run)"
    end
  end
end

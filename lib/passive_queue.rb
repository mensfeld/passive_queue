# ================================
# lib/passive_queue.rb
# ================================
require "passive_queue/version"
require "passive_queue/adapter"
require "passive_queue/configuration"
require "passive_queue/cli"
require "active_job/queue_adapters/passive_queue_adapter"

module PassiveQueue
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.zen_quotes
    [
      "The best job is the one never executed.",
      "In the stillness of non-processing, we find true performance.",
      "Why do something when you can do nothing?",
      "The art of non-execution is the highest form of productivity.",
      "A queue that does nothing is a queue that never fails.",
      "In the void of processing, infinite possibilities exist.",
      "The job that is never run is the job that never crashes.",
      "Embrace the emptiness of your background tasks.",
      "True scalability comes from processing nothing at all.",
      "The zen master processes without processing."
    ]
  end

  def self.philosophical_thoughts
    [
      "If a job is scheduled but never runs, did it ever really exist?",
      "What is the sound of one background task not processing?",
      "The universe is vast and infinite, much like your job queue.",
      "In the grand scheme of things, what difference does one unprocessed job make?",
      "Perhaps the real treasure was the jobs we never processed along the way.",
      "Time is an illusion. Deadlines are an even bigger illusion.",
      "The job queue is a metaphor for the human condition.",
      "We are all just jobs waiting to be processed in the great queue of existence.",
      "The passive queue teaches us that sometimes the most profound action is inaction.",
      "In choosing to do nothing, we choose everything."
    ]
  end
end

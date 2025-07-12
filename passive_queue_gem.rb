# passive_queue.gemspec
require_relative "lib/passive_queue/version"

Gem::Specification.new do |spec|
  spec.name = "passive_queue"
  spec.version = PassiveQueue::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "A Rails queue adapter that embraces the zen of non-productivity"
  spec.description = "Passive Queue is a Rails queue adapter that parodies Solid Queue by doing absolutely nothing. Perfect for meditation and the art of non-execution."
  spec.homepage = "https://github.com/yourusername/passive_queue"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yourusername/passive_queue"
  spec.metadata["changelog_uri"] = "https://github.com/yourusername/passive_queue/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # NO runtime dependencies - true zen has no dependencies
  
  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rails", ">= 6.0"
end

# ================================
# lib/passive_queue.rb
# ================================
require "passive_queue/version"
require "passive_queue/adapter"
require "passive_queue/configuration"
require "passive_queue/job"
require "passive_queue/cli"

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

# ================================
# lib/passive_queue/version.rb
# ================================
module PassiveQueue
  VERSION = "0.1.0"
end

# ================================
# lib/passive_queue/configuration.rb
# ================================
module PassiveQueue
  class Configuration
    attr_accessor :meditation_duration, :zen_level, :philosophical_depth, :silence_mode

    def initialize
      @meditation_duration = 5 # seconds
      @zen_level = :medium
      @philosophical_depth = :shallow
      @silence_mode = false
    end

    def zen_levels
      %i[low medium high transcendent]
    end

    def philosophical_depths
      %i[shallow deep profound existential]
    end
  end
end

# ================================
# lib/passive_queue/adapter.rb
# ================================

# ================================
# lib/passive_queue/job.rb
# ================================
module PassiveQueue
  class Job
    attr_reader :active_job, :scheduled_at, :id

    def initialize(active_job, scheduled_at = nil)
      @active_job = active_job
      @scheduled_at = scheduled_at
      @id = generate_uuid
      @accepted_at = Time.now
    end

    def execute
      # The art of non-execution
      raise NotImplementedError, "True zen masters never execute"
    end

    def status
      "successfully_not_processed"
    end

    def processed?
      false # Never processed, always at peace
    end

    def failed?
      false # Cannot fail if never executed
    end

    def succeeded?
      true # Always successful at doing nothing
    end

    def queue_name
      @active_job.queue_name
    end

    def arguments
      @active_job.arguments
    end

    def job_class
      @active_job.class.name
    end

    def to_h
      {
        id: @id,
        job_class: job_class,
        queue_name: queue_name,
        arguments: arguments,
        scheduled_at: @scheduled_at,
        accepted_at: @accepted_at,
        status: status,
        processed: processed?,
        failed: failed?,
        succeeded: succeeded?
      }
    end

    private

    def generate_uuid
      # Simple UUID generation without external dependencies
      ary = SecureRandom.random_bytes(16).unpack("NnnnnN")
      ary[2] = (ary[2] & 0x0fff) | 0x4000
      ary[3] = (ary[3] & 0x3fff) | 0x8000
      "%08x-%04x-%04x-%04x-%04x%08x" % ary
    rescue
      # Fallback if SecureRandom is not available
      Time.now.to_i.to_s(36) + rand(1000000).to_s(36)
    end
  end
end

# ================================
# lib/passive_queue/cli.rb
# ================================
module PassiveQueue
  class CLI
    def self.start(args)
      new.run(args)
    end

    def run(args)
      # Parse arguments manually (no Thor dependency)
      options = parse_args(args)
      
      case args.first
      when "passive", nil
        passive_command(options)
      when "help", "-h", "--help"
        show_help
      else
        puts "Unknown command: #{args.first}"
        show_help
        exit(1)
      end
    end

    private

    def parse_args(args)
      options = {
        zen: false,
        philosophical: false,
        aggressive: false,
        duration: 5
      }

      args.each_with_index do |arg, index|
        case arg
        when "--zen"
          options[:zen] = true
        when "--philosophical"
          options[:philosophical] = true
        when "--aggressive"
          options[:aggressive] = true
        when "--duration"
          options[:duration] = args[index + 1].to_i if args[index + 1]
        end
      end

      options
    end

    def passive_command(options)
      if options[:aggressive]
        puts "❌ Error: Don't be aggressive! The path of the passive queue is one of peace."
        puts "   Try running without the --aggressive flag to find inner tranquility."
        exit(1)
      end

      duration = options[:duration] || PassiveQueue.configuration.meditation_duration
      
      puts "🧘 Entering passive meditation mode..."
      puts "   Duration: #{duration} seconds"
      puts "   Zen level: #{PassiveQueue.configuration.zen_level}"
      puts ""
      
      start_time = Time.now
      
      if options[:zen] || options[:philosophical]
        meditate_with_wisdom(duration, options)
      else
        meditate_silently(duration)
      end
      
      end_time = Time.now
      elapsed = (end_time - start_time).round(2)
      
      puts ""
      puts "✨ Meditation complete! You successfully did nothing for #{elapsed} seconds."
      puts "   Your passive queue energy has been restored."
    end

    def meditate_with_wisdom(duration, options)
      interval = duration / 3.0
      
      3.times do |i|
        if options[:zen]
          puts "💭 #{PassiveQueue.zen_quotes.sample}"
        elsif options[:philosophical]
          puts "🤔 #{PassiveQueue.philosophical_thoughts.sample}"
        end
        
        sleep(interval) unless i == 2
        puts "" unless i == 2
      end
    end

    def meditate_silently(duration)
      print "   Meditating"
      
      dots = 0
      start_time = Time.now
      
      while Time.now - start_time < duration
        sleep(0.5)
        print "."
        dots += 1
        
        if dots >= 6
          print "\r   Meditating"
          dots = 0
        end
      end
    end

    def show_help
      puts <<~HELP
        Passive Queue CLI - The zen of non-productivity
        
        Usage:
          be passive [options]
          
        Options:
          --zen              Enable zen quotes during meditation
          --philosophical    Enable philosophical thoughts
          --aggressive       Be aggressively passive (not recommended)
          --duration N       Set meditation duration in seconds (default: 5)
          --help, -h         Show this help message
        
        Examples:
          be passive                      # Basic meditation
          be passive --zen               # With zen quotes
          be passive --philosophical     # Deep thoughts
          be passive --duration 10       # 10 second meditation
          
        Remember: The best job is the one never executed. 🌟
      HELP
    end
  end
end

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

      generators do
        require "passive_queue/generators/install_generator"
      end
    end
  end
rescue LoadError
  # Rails not available, that's fine - we embrace the void
end

# ================================
# lib/generators/passive_queue/install_generator.rb
# ================================
begin
  require "rails/generators"
  
  module PassiveQueue
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("templates", __dir__)

        desc "Install Passive Queue configuration"

        def create_initializer
          create_file "config/initializers/passive_queue.rb", <<~RUBY
            # Passive Queue Configuration
            # The zen of non-execution requires no configuration, but here it is anyway.

            PassiveQueue.configure do |config|
              # Duration for 'be passive' meditation (in seconds)
              config.meditation_duration = 5
              
              # Zen level for spiritual enlightenment
              # Options: :low, :medium, :high, :transcendent
              config.zen_level = :medium
              
              # Philosophical depth for deep thoughts
              # Options: :shallow, :deep, :profound, :existential
              config.philosophical_depth = :shallow
              
              # Silence mode - when true, suppresses all output
              config.silence_mode = false
            end
          RUBY
        end

        def add_queue_adapter_configuration
          inject_into_file "config/application.rb", after: "class Application < Rails::Application\n" do
            <<~RUBY
              # Configure Passive Queue as the background job adapter
              # This will make all ActiveJob jobs do absolutely nothing
              config.active_job.queue_adapter = :passive_queue
            RUBY
          end
        end

        def display_instructions
          say <<~TEXT
            
            🧘 Passive Queue has been installed successfully!
            
            Your Rails application is now configured to use Passive Queue as the
            background job adapter. All your ActiveJob jobs will now be processed
            with the zen of non-execution.
            
            Try these commands:
            
              bundle exec be passive              # Basic meditation
              bundle exec be passive --zen       # With zen quotes
              bundle exec be passive --philosophical  # Deep thoughts
            
            Configuration file created at: config/initializers/passive_queue.rb
            
            Remember: The best job is the one never executed. 🌟
          TEXT
        end
      end
    end
  end
rescue LoadError
  # Rails generators not available, we accept this with grace
end

# ================================
# exe/be
# ================================
#!/usr/bin/env ruby

require "bundler/setup"
require "passive_queue"

PassiveQueue::CLI.start(ARGV)

# ================================
# Rakefile
# ================================
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Run the passive meditation CLI"
task :meditate do
  system("ruby exe/be passive --zen")
end

# ================================
# .gitignore
# ================================
/.bundle/
/.yardoc
/_yardoc/
/coverage/
/doc/
/pkg/
/spec/reports/
/tmp/

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Log files
*.log

# Gem files
*.gem

# ================================
# Gemfile
# ================================
source "https://rubygems.org"

gemspec

gem "rake", "~> 13.0"
gem "rspec", "~> 3.0"

# ================================
# lib/active_job/queue_adapters/passive_queue_adapter.rb
# ================================
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

# ================================
# spec/spec_helper.rb
# ================================
require "bundler/setup"
require "passive_queue"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# ================================
# spec/passive_queue_spec.rb
# ================================
RSpec.describe PassiveQueue do
  it "has a version number" do
    expect(PassiveQueue::VERSION).not_to be nil
  end

  it "provides zen quotes" do
    expect(PassiveQueue.zen_quotes).to be_an(Array)
    expect(PassiveQueue.zen_quotes).not_to be_empty
    expect(PassiveQueue.zen_quotes.first).to be_a(String)
  end

  it "provides philosophical thoughts" do
    expect(PassiveQueue.philosophical_thoughts).to be_an(Array)
    expect(PassiveQueue.philosophical_thoughts).not_to be_empty
    expect(PassiveQueue.philosophical_thoughts.first).to be_a(String)
  end

  it "can be configured" do
    PassiveQueue.configure do |config|
      config.meditation_duration = 10
      config.zen_level = :high
    end

    expect(PassiveQueue.configuration.meditation_duration).to eq(10)
    expect(PassiveQueue.configuration.zen_level).to eq(:high)
  end
end

# ================================
# spec/passive_queue/adapter_spec.rb
# ================================
require "spec_helper"

RSpec.describe PassiveQueue::Adapter do
  let(:adapter) { described_class.new }
  let(:mock_job) { double("ActiveJob", class: double(name: "TestJob"), arguments: ["arg1"], queue_name: "default") }

  describe "#enqueue" do
    it "accepts a job and returns a Job wrapper" do
      result = adapter.enqueue(mock_job)
      expect(result).to be_a(PassiveQueue::Job)
    end

    it "does not actually process the job" do
      expect(mock_job).not_to receive(:perform)
      adapter.enqueue(mock_job)
    end
  end

  describe "#enqueue_at" do
    it "schedules a job for never" do
      timestamp = Time.current.to_i + 3600
      result = adapter.enqueue_at(mock_job, timestamp)
      expect(result).to be_a(PassiveQueue::Job)
    end
  end

  describe "#enqueue_all" do
    it "accepts multiple jobs" do
      jobs = [mock_job, mock_job]
      results = adapter.enqueue_all(jobs)
      expect(results).to all(be_a(PassiveQueue::Job))
      expect(results.length).to eq(2)
    end
  end
end

# ================================
# spec/passive_queue/job_spec.rb
# ================================
require "spec_helper"

RSpec.describe PassiveQueue::Job do
  let(:mock_active_job) { double("ActiveJob", class: double(name: "TestJob"), arguments: ["arg1"], queue_name: "default") }
  let(:job) { described_class.new(mock_active_job) }

  describe "#execute" do
    it "raises NotImplementedError" do
      expect { job.execute }.to raise_error(NotImplementedError, "True zen masters never execute")
    end
  end

  describe "#status" do
    it "returns successfully_not_processed" do
      expect(job.status).to eq("successfully_not_processed")
    end
  end

  describe "#processed?" do
    it "returns false" do
      expect(job.processed?).to be false
    end
  end

  describe "#failed?" do
    it "returns false" do
      expect(job.failed?).to be false
    end
  end

  describe "#succeeded?" do
    it "returns true" do
      expect(job.succeeded?).to be true
    end
  end

  describe "#to_h" do
    it "returns a hash representation" do
      hash = job.to_h
      expect(hash).to include(
        :id, :job_class, :queue_name, :arguments, :status, :processed, :failed, :succeeded
      )
      expect(hash[:job_class]).to eq("TestJob")
      expect(hash[:succeeded]).to be true
    end
  end
end

# ================================
# .rspec
# ================================
--format documentation
--color
--require spec_helper
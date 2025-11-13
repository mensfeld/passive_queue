# ================================
# lib/passive_queue/cli.rb
# ================================
module PassiveQueue
  # Command-line interface for PassiveQueue meditation and zen commands
  class CLI
    # Entry point for the CLI application
    #
    # @param args [Array<String>] command-line arguments
    # @return [void]
    def self.start(args)
      new.run(args)
    end

    # Runs the CLI with provided arguments
    #
    # @param args [Array<String>] command-line arguments to process
    # @return [void]
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

    # Parses command-line arguments into an options hash
    #
    # @param args [Array<String>] raw command-line arguments
    # @return [Hash] parsed options with zen, philosophical, aggressive, and duration keys
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

    # Executes the passive meditation command
    #
    # @param options [Hash] parsed command-line options
    # @return [void]
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

    # Meditates with zen quotes or philosophical thoughts
    #
    # @param duration [Numeric] meditation duration in seconds
    # @param options [Hash] options hash containing zen or philosophical flags
    # @return [void]
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

    # Meditates silently with animated dots
    #
    # @param duration [Numeric] meditation duration in seconds
    # @return [void]
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

    # Displays help information for the CLI
    #
    # @return [void]
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

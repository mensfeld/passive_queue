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

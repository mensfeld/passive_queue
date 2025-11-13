# ================================
# lib/passive_queue/configuration.rb
# ================================
module PassiveQueue
  # Configuration settings for PassiveQueue behavior and aesthetics
  class Configuration
    # @return [Integer] meditation duration in seconds
    attr_accessor :meditation_duration

    # @return [Symbol] current zen level (:low, :medium, :high, :transcendent)
    attr_accessor :zen_level

    # @return [Symbol] philosophical depth (:shallow, :deep, :profound, :existential)
    attr_accessor :philosophical_depth

    # @return [Boolean] whether to suppress output logging
    attr_accessor :silence_mode

    # Initializes configuration with default zen values
    def initialize
      @meditation_duration = 5 # seconds
      @zen_level = :medium
      @philosophical_depth = :shallow
      @silence_mode = false
    end

    # Returns available zen levels
    #
    # @return [Array<Symbol>] valid zen level options
    def zen_levels
      %i[low medium high transcendent]
    end

    # Returns available philosophical depth levels
    #
    # @return [Array<Symbol>] valid philosophical depth options
    def philosophical_depths
      %i[shallow deep profound existential]
    end
  end
end

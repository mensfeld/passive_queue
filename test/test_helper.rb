require 'minitest/autorun'
require 'minitest/spec'
require 'passive_queue'

FakeJob = Struct.new(:arguments, :queue_name) do
  def self.name
    'FakeJob'
  end
end

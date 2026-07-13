# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  minimum_coverage line: 95, branch: 90
  skip '/test/'
  skip '/lib/passive_queue/railtie.rb'
  skip '/lib/active_job/'
end

require 'minitest/autorun'
require 'minitest/spec'
require 'passive_queue'

FakeJob = Struct.new(:arguments, :queue_name) do
  def self.name
    'FakeJob'
  end
end

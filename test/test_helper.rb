# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/test/'
  add_filter '/lib/passive_queue/railtie.rb'
  add_filter '/lib/active_job/'
end

require 'minitest/autorun'
require 'minitest/spec'
require 'passive_queue'

FakeJob = Struct.new(:arguments, :queue_name) do
  def self.name
    'FakeJob'
  end
end

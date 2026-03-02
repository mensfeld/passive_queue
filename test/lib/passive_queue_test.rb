# frozen_string_literal: true

describe PassiveQueue do
  describe '.configuration' do
    it 'returns a Configuration instance' do
      assert_instance_of PassiveQueue::Configuration, PassiveQueue.configuration
    end
  end

  describe '.configure' do
    it 'yields the configuration' do
      PassiveQueue.configure do |config|
        assert_instance_of PassiveQueue::Configuration, config
      end
    end
  end

  describe '.zen_quotes' do
    it 'returns an array of 10 strings' do
      quotes = PassiveQueue.zen_quotes
      assert_instance_of Array, quotes
      assert_equal 10, quotes.length
      quotes.each { |q| assert_instance_of String, q }
    end
  end

  describe '.philosophical_thoughts' do
    it 'returns an array of 10 strings' do
      thoughts = PassiveQueue.philosophical_thoughts
      assert_instance_of Array, thoughts
      assert_equal 10, thoughts.length
      thoughts.each { |t| assert_instance_of String, t }
    end
  end

  describe 'Error' do
    it 'inherits from StandardError' do
      assert_operator PassiveQueue::Error, :<, StandardError
    end
  end
end

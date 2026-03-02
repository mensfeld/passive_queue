require 'test_helper'
require 'rack'

describe PassiveQueue::Engine do
  describe '.call' do
    it 'delegates to Web and returns a Rack triplet' do
      env = Rack::MockRequest.env_for('/')
      result = PassiveQueue::Engine.call(env)
      assert_instance_of Array, result
      assert_equal 3, result.length
      assert_equal 200, result[0]
    end
  end
end

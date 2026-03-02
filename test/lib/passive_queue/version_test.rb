# frozen_string_literal: true

describe PassiveQueue::VERSION do
  it 'is a string' do
    assert_instance_of String, PassiveQueue::VERSION
  end

  it 'matches semver pattern' do
    assert_match(/\A\d+\.\d+\.\d+\z/, PassiveQueue::VERSION)
  end
end

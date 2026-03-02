require 'test_helper'

describe PassiveQueue::Configuration do
  let(:config) { PassiveQueue::Configuration.new }

  describe 'defaults' do
    it 'has meditation_duration of 5' do
      assert_equal 5, config.meditation_duration
    end

    it 'has zen_level of :medium' do
      assert_equal :medium, config.zen_level
    end

    it 'has philosophical_depth of :shallow' do
      assert_equal :shallow, config.philosophical_depth
    end

    it 'has silence_mode of false' do
      assert_equal false, config.silence_mode
    end
  end

  describe 'accessors' do
    it 'allows setting meditation_duration' do
      config.meditation_duration = 10
      assert_equal 10, config.meditation_duration
    end

    it 'allows setting zen_level' do
      config.zen_level = :transcendent
      assert_equal :transcendent, config.zen_level
    end

    it 'allows setting philosophical_depth' do
      config.philosophical_depth = :existential
      assert_equal :existential, config.philosophical_depth
    end

    it 'allows setting silence_mode' do
      config.silence_mode = true
      assert_equal true, config.silence_mode
    end
  end

  describe '#zen_levels' do
    it 'returns 4 symbols' do
      levels = config.zen_levels
      assert_equal 4, levels.length
      levels.each { |l| assert_instance_of Symbol, l }
    end
  end

  describe '#philosophical_depths' do
    it 'returns 4 symbols' do
      depths = config.philosophical_depths
      assert_equal 4, depths.length
      depths.each { |d| assert_instance_of Symbol, d }
    end
  end
end

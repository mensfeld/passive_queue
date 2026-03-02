# frozen_string_literal: true

describe PassiveQueue::Adapter do
  let(:adapter) { PassiveQueue::Adapter.new }
  let(:job) { FakeJob.new([], 'default') }

  before do
    PassiveQueue.configuration.silence_mode = true
  end

  after do
    PassiveQueue.configuration.silence_mode = false
  end

  describe '#enqueue' do
    it 'accepts a job and returns nil' do
      assert_nil adapter.enqueue(job)
    end
  end

  describe '#enqueue_at' do
    it 'accepts a job and timestamp' do
      assert_nil adapter.enqueue_at(job, Time.now.to_i)
    end
  end

  describe '#enqueue_all' do
    it 'returns an array' do
      result = adapter.enqueue_all([job, job])
      assert_instance_of Array, result
    end
  end

  describe '#stopping?' do
    it 'returns true' do
      assert_equal true, adapter.stopping?
    end
  end

  describe 'silence_mode' do
    it 'suppresses output when enabled' do
      PassiveQueue.configuration.silence_mode = true
      output = capture_io { adapter.enqueue(job) }
      assert_empty output[0]
    end

    it 'produces output when disabled' do
      PassiveQueue.configuration.silence_mode = false
      output = capture_io { adapter.enqueue(job) }
      refute_empty output[0]
    end

    it 'logs enqueue_at output when silence_mode is disabled' do
      PassiveQueue.configuration.silence_mode = false
      output = capture_io { adapter.enqueue_at(job, Time.now.to_i) }
      assert_includes output[0], 'Scheduled FakeJob'
    end

    it 'includes arguments in enqueue output when present' do
      PassiveQueue.configuration.silence_mode = false
      job_with_args = FakeJob.new([1, 2], 'default')
      output = capture_io { adapter.enqueue(job_with_args) }
      assert_includes output[0], 'Arguments:'
    end
  end
end

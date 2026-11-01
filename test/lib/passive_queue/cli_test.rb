# frozen_string_literal: true

describe PassiveQueue::CLI do
  let(:cli) { PassiveQueue::CLI.new }

  let(:nosleep_cli) do
    instance = PassiveQueue::CLI.new
    instance.define_singleton_method(:sleep) { |_| }
    instance
  end

  describe '#parse_args' do
    it 'returns default options for empty args' do
      options = cli.send(:parse_args, [])
      assert_equal false, options[:zen]
      assert_equal false, options[:philosophical]
      assert_equal false, options[:aggressive]
      assert_equal false, options[:help]
      assert_nil options[:duration]
    end

    it 'parses --zen flag' do
      options = cli.send(:parse_args, ['--zen'])
      assert_equal true, options[:zen]
    end

    it 'parses --philosophical flag' do
      options = cli.send(:parse_args, ['--philosophical'])
      assert_equal true, options[:philosophical]
    end

    it 'parses --aggressive flag' do
      options = cli.send(:parse_args, ['--aggressive'])
      assert_equal true, options[:aggressive]
    end

    it 'parses --help and -h flags at any position' do
      assert_equal true, cli.send(:parse_args, ['passive', '--help'])[:help]
      assert_equal true, cli.send(:parse_args, ['passive', '--zen', '-h'])[:help]
    end

    it 'parses --duration with value' do
      options = cli.send(:parse_args, ['--duration', '10'])
      assert_equal 10, options[:duration]
    end
  end

  describe '#run' do
    it 'exits with SystemExit for --aggressive' do
      assert_raises(SystemExit) do
        capture_io { cli.run(['passive', '--aggressive']) }
      end
    end

    it 'shows help for help command' do
      output = capture_io { cli.run(['help']) }
      assert_includes output[0], 'Passive Queue CLI'
    end

    it 'shows help for -h flag' do
      output = capture_io { cli.run(['-h']) }
      assert_includes output[0], 'Passive Queue CLI'
    end

    it 'shows help for --help flag' do
      output = capture_io { cli.run(['--help']) }
      assert_includes output[0], 'Passive Queue CLI'
    end

    it 'shows help instead of meditating for passive --help' do
      output = capture_io { nosleep_cli.run(['passive', '--help']) }
      assert_includes output[0], 'Passive Queue CLI'
      refute_includes output[0], 'Entering passive meditation mode'
    end

    it 'uses configured meditation_duration when --duration is not given' do
      original = PassiveQueue.configuration.meditation_duration
      PassiveQueue.configuration.meditation_duration = 0
      output = capture_io { nosleep_cli.run(['passive']) }
      assert_includes output[0], 'Duration: 0 seconds'
    ensure
      PassiveQueue.configuration.meditation_duration = original
    end

    it 'prefers --duration over configured meditation_duration' do
      original = PassiveQueue.configuration.meditation_duration
      PassiveQueue.configuration.meditation_duration = 7
      output = capture_io { nosleep_cli.run(['passive', '--duration', '0']) }
      assert_includes output[0], 'Duration: 0 seconds'
    ensure
      PassiveQueue.configuration.meditation_duration = original
    end

    it 'exits with SystemExit for unknown commands' do
      assert_raises(SystemExit) do
        capture_io { cli.run(['unknown_command']) }
      end
    end

    it 'runs passive command by default when no args given' do
      output = capture_io { nosleep_cli.run(['passive', '--duration', '0']) }
      assert_includes output[0], 'Entering passive meditation mode'
      assert_includes output[0], 'Meditation complete'
    end

    it 'runs passive command with --zen flag' do
      output = capture_io { nosleep_cli.run(['passive', '--zen', '--duration', '0']) }
      assert_includes output[0], 'Entering passive meditation mode'
      assert_includes output[0], 'Meditation complete'
    end
  end

  describe 'meditation' do
    it 'meditates silently with animated dots' do
      output = capture_io { nosleep_cli.send(:meditate_silently, 0.001) }
      assert_includes output[0], 'Meditating'
    end

    it 'meditates with zen quotes' do
      output = capture_io { nosleep_cli.send(:meditate_with_wisdom, 0, { zen: true }) }
      refute_empty output[0]
    end

    it 'sleeps three intervals totalling the duration with wisdom' do
      sleeps = []
      instance = PassiveQueue::CLI.new
      instance.define_singleton_method(:sleep) { |seconds| sleeps << seconds }
      capture_io { instance.send(:meditate_with_wisdom, 9, { zen: true }) }
      assert_equal [3.0, 3.0, 3.0], sleeps
    end

    it 'meditates with philosophical thoughts' do
      output = capture_io { nosleep_cli.send(:meditate_with_wisdom, 0, { philosophical: true }) }
      refute_empty output[0]
    end
  end

  describe '.start' do
    it 'creates a new instance and runs it' do
      output = capture_io do
        assert_raises(SystemExit) { PassiveQueue::CLI.start(['unknown']) }
      end
      assert_includes output[0], 'Unknown command'
    end
  end
end

require 'test_helper'

describe PassiveQueue::CLI do
  let(:cli) { PassiveQueue::CLI.new }

  describe '#parse_args' do
    it 'returns default options for empty args' do
      options = cli.send(:parse_args, [])
      assert_equal false, options[:zen]
      assert_equal false, options[:philosophical]
      assert_equal false, options[:aggressive]
      assert_equal 5, options[:duration]
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

    it 'exits with SystemExit for unknown commands' do
      assert_raises(SystemExit) do
        capture_io { cli.run(['unknown_command']) }
      end
    end
  end
end

require 'minitest/autorun'
require 'minitest/pride'
require 'tidy_logger'
require 'stringio'
require 'time'

class TestTidyLogger < MiniTest::Unit::TestCase
  def setup
    @io = StringIO.new
    @logger = TidyLogger.new(@io)
  end

  def test_default_format
    @logger.info 'buzz'
    assert @io.string =~ /^I, \[(\S+) #\d+\]  INFO -- : buzz$/, 'format mismatch'
    assert_instance_of Time, Time.iso8601($1)
  end

  def test_skip_debug_by_default
    @logger.config
    @logger.debug 'buzz'
    assert_equal '', @io.string
  end

  def test_time_and_level
    @logger.config
    @logger.info 'buzz'
    assert @io.string =~ /^\[(\S+)\]  INFO : buzz$/, 'format mismatch'
    assert_instance_of Time, Time.iso8601($1)
  end

  def test_plain
    @logger.config(:plain)
    @logger.info 'buzz'
    assert_equal "buzz\n", @io.string
  end

  def test_title
    @logger.config(:title => 'fizz')
    @logger.info 'buzz'
    assert_equal "[fizz] buzz\n", @io.string
  end

  def test_time
    @logger.config(:time)
    @logger.info 'buzz'
    assert @io.string =~ /^\[(\S+)\] buzz$/, 'format mismatch'
    assert_instance_of Time, Time.iso8601($1)
  end

  def test_ltsv
    @logger.config(:ltsv)
    @logger.info :fizz => 1, :buzz => 2
    assert_equal "fizz:1\tbuzz:2\n", @io.string
  end

  def test_lambda
    @logger.config(lambda{|_,_,_,msg| "||do crazy stuff|| #{msg2str(msg)}\n" })
    @logger.info 'buzz'
    assert_equal "||do crazy stuff|| buzz\n", @io.string
  end
end

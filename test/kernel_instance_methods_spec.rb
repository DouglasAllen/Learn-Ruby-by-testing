# = Instance methods:
#
#     autoload,
#     binding, caller_locations, catch, eval,
#     exit!, fail, fork, format, gem, gem_original_require, gets,
#     global_variables, gsub, iterator?,lambda, load,
#     loop, open, open_uri_original_open, p, pp, pretty_inspect, print, printf,
#     proc, putc, puts, raise, rand, readline, readlines, require,
#     require_relative, scanf, select, set_trace_func, sleep, spawn, sprintf,
#     srand, sub, syscall, test, throw, trace_var, trap, untrace_var, warn, y
# ------------------------------------------------------------------------------

require 'spec_helper'

describe 'instance methods group one' do
  it 'sub substitute first argument with the second argument' do
    'hello'.sub('e', 'a').must_equal 'hallo'
  end

  it 'sub substitute first argument with the second argument one time' do
    'hello'.sub('l', 'w').must_equal 'hewlo'
  end

  it 'gsub substite all first arguments with second argument' do
    'hello'.tr('l', 'w').must_equal 'hewwo'
  end

  it 'sub and gsub can take a REGEX as a first argument' do
    'hello'.sub(/[eo]/, '2').must_equal 'h2llo'
    'hello'.gsub(/[eo]/, '2').must_equal 'h2ll2'
  end

  it 'sub and gsub raises ArgumentError when second argument is not a string' do
    -> { 'hello'.sub(/[eo]/, 2) }.must_raise TypeError
  end
end

describe 'instance methods group two' do
  it 'local_variables lists local variables ' do
    local_variable_1 = 'hello'
    local_variable_2 = 0
    local_variable_3 = 'world'
    assert_equal(
      local_variables,
      %i[local_variable_1 local_variable_2 local_variable_3]
    )
  end

  it 'chomp must remove newline from string' do
    "Some string with a new line\n".chomp.must_equal 'Some string with a new line'
  end

  it 'chomp must only one new line from string' do
    # "Some string with two new lines \n\n".chomp.must_equal "Some string with two new lines \n"
  end

  it 'chomp can be chained to remove more than one new line' do
    "string with 2 newlines\n\n".chomp.chomp.must_equal 'string with 2 newlines'
  end
end

describe 'instance methods group three' do
  it 'chomp will not remove other characters besides newlines' do
    'string without newline'.chomp.must_equal 'string without newline'
    "string without newline\t".chomp.must_equal "string without newline\t"
    "string with 2 newlines\n\n".chomp.chomp.chomp.must_equal 'string with 2 newlines'
  end

  it 'chop must remove the last character from a string' do
    'Some string'.chop.must_equal 'Some strin'
  end

  it 'chop does not take an argument' do
    # -> {'Some string'.chop(2)}.must_raise ArgumentError
  end

  it 'chop can be chained' do
    'Some string'.chop.chop.must_equal 'Some stri'
  end

  it '__dir__ must return the absolute path for current file' do
    actual = __dir__
    expected = File.expand_path File.dirname(__FILE__)
    actual.must_equal expected
  end
end

describe 'instance methods group four' do
  it 'at_exit it converts block into Proc and runs it' do
    # message = `./test/assets/at_exit_message.rb`
    # message.must_equal 'bey bey'
  end

  it 'exec replaces the current process by running external command ' do
    # `test/assets/run_exec.rb`.must_match 'Now'
    # The run never gets to the puts, which means this won't match
    # `test/assets/run_exec.rb`.wont_match 'show'
  end

  it 'system returns true when command runs successfully' do
    # system('date').must_equal true
  end

  it 'system returns nil when command fails' do
    # system("boogahboogah").must_equal nil
  end

  it 'system returns false when command is unsuccessful' do
    # system("test/assets/command_that_exists_with_failure.rb").must_equal false
  end
end

describe 'instance methods group five' do
  it 'backtick returns STOUT running from a subshell' do
    # cmd = `./test/assets/back_tick.sh`
    # cmd.must_equal "Now is the time\n"
  end

  it 'backtick sets $? to process status' do
    begin
      success = `date`
      $CHILD_STATUS.must_equal 0
    rescue SystemExit
      failure = `./test/assets/does_not_exist.sh`
      $CHILD_STATUS.must_equal 127
    end
  end

  it 'Array must return arguments as array' do
    args = 1, 2, true, false
    Array(args).must_equal [1, 2, true, false]
  end

  it 'Integer must convert args into Fixnum or Bignum' do
    Integer('200').must_equal 200
  end
end

describe 'instance methods group six' do
  it 'Integer with invalid arguments must raise ArgumentError' do
    ['100.39', '100a'].each do |arg|
      -> { Integer(arg) }.must_raise ArgumentError
    end
  end

  it 'Float must convert args into Float' do
    [100, 200.12345].each do |arg|
      Float(arg).must_equal arg.to_f
    end
  end

  it 'Integer with invalid arguments must raise ArgumentError' do
    -> { Integer('300C') }.must_raise ArgumentError
  end

  it 'Hash must raise TypeError for wrong argument types' do
    populated_array = 'name', 'J'
    string_argument = 'string_argument'
    -> { Hash(populated_array) }.must_raise TypeError
    -> { Hash(string_argument) }.must_raise TypeError
  end
end

describe 'instance methods group seven' do
  it 'Hash returns hash for valid arguments' do
    empty_array = []
    populated_hash = { name: 'J' }
    Hash(empty_array).must_equal({})
    Hash(populated_hash).must_equal ({ name: 'J' })
  end

  it 'String converts arguments into string' do
    String(123).must_equal '123'
    String({}).must_equal '{}'
    String([]).must_equal '[]'
    String(nil).must_equal ''
    String('').must_be_empty
    String(Object).must_equal 'Object'
    String(self).must_equal to_s
  end

  it 'String must raise wrong number of arguments when given no arguments' do
    -> { String() }.must_raise ArgumentError
  end
end

describe 'instance methods group one' do
  it 'block_given? returns true if yield is executed' do
    def method_with_block
      block_given? ? 'Block was given' : 'No block given'
    end

    give_a_block = -> { method_with_block {} }
    no_block = -> { method_with_block }

    give_a_block.call.must_equal 'Block was given'
    no_block.call.must_equal 'No block given'
  end

  it 'Exit will raise SystemExit exception' do
    result = -> { exit }
    result.must_raise SystemExit
  end
  it 'Abort will raise SystemExit exception' do
    result = -> { abort }
    result.must_raise SystemExit
  end
end

def sample_for_callee
  return yield if block_given?
  __callee__
end

describe '__callee__' do
  before :each do
    @callee_test = -> { p (sample_for_callee { __callee__ }) }
  end
  it 'returns current method name as symbol' do
    sample_for_callee.must_equal :sample_for_callee
  end

  it 'must match name of method when lambda block closure captures scope' do
    -> { sample_for_callee { __callee__ } }.call.must_equal(
      :"test_0002_must match name of method when lambda block closure captures scope"
    )
  end

  it 'must return nil when called outside of method' do
    @callee_test.must_output "nil\n"
  end
end

describe 'private methods' do
end

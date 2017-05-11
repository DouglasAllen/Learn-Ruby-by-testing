require 'spec_helper'

# describe String do

describe 'Class Methods' do
  it '.new creates new string' do
    String.new('new string').must_equal 'new string'
  end

  it 'must instantiate by using string literal' do
    ''.class.must_equal String
  end

  it 'try_convert' do
    String.try_convert('').must_equal ''
    String.try_convert('1').must_equal '1'
    assert_nil(String.try_convert(1), nil)
    assert_nil(String.try_convert(['', 1]), nil)
  end
end

describe 'Instance Methods group one' do
  before :each do
    @my_string = 'A test string with punctuation, and 1 2 3 numbers, and symbols such as @ or #. In the winter or summer.'
  end

  it 'sum takes the codepoints of the string and adds them together, creating a low quality checksum' do
    original_string = 'The brown dog jumped over the lazy fox'
    sorted_string = original_string.split(//).join('')
    sorted_string.sum.must_equal original_string.sum
  end

  it 'must multiply a string with * method' do
    ('Hi' * 2).must_equal 'HiHi'
  end

  it 'must split a string by space by default' do
    'Learning Ruby by testing is fun'.split.must_equal %w[Learning Ruby by testing is fun]
  end

  it 'must convert string to integer base' do
    '42'.to_i.must_equal 42
    '42'.to_i(8).must_equal 34
    '42'.to_i(16).must_equal 66
    'a0'.to_i(16).must_equal 160
    'a0'.to_i(11).must_equal 110
    '11'.to_i(2).must_equal 3
    '20'.to_i(3).must_equal 6
    'zz'.to_i(36).must_equal 1295
  end
end

describe 'Instance Methods group two' do
  before :each do
    @my_string = 'A test string with punctuation, and 1 2 3 numbers, and symbols such as @ or #. In the winter or summer.'
  end
  it 'must fail when converting to integer base 37' do
    proc { '42'.to_i(37) }.must_raise ArgumentError
  end

  it 'must split by whatever delimiter is given' do
    'Learning Ruby by testing is fun'.split('i').must_equal ['Learn', 'ng Ruby by test', 'ng ', 's fun']
  end

  it "must split on whitespace when ' ' is given" do
    expected = %w[Small line with whitespace]
    "Small line\nwith whitespace".split(' ').must_equal expected
  end

  it 'must split on only newline when /\n/ is given' do
    expected = ['Small line', 'with whitespace']
    "Small line\nwith whitespace".split(/\n/).must_equal expected
  end

  it 'must be able to determine the length of a string' do
    @my_string.length.must_equal 103
  end

  it 'must be able to determine the size of a string' do
    @my_string.size.must_equal 103
  end
end

describe 'Instance Methods group three' do
  it 'must be able to substitube globally' do
    result = 'Now is the time to rejoice for the season.'
    'Now is a time to rejoice for a season.'.gsub(' a ', ' the ').must_equal result
  end

  it 'must be able to substitute with a hash value given' do
    text = 'The learning is fun at RLO and the blog is
    available at RLCB, along with tutorials and other
    links at RLC.'
    result = 'The learning is fun at http://rubylearning.org and the blog is
    available at http://rubylearning.com/blog, along with tutorials and other
    links at http://rubylearning.com.'
    text.gsub(/RL(O|CB|C)/,
              'RLO' => 'http://rubylearning.org',
              'RLC' => 'http://rubylearning.com',
              'RLCB' => 'http://rubylearning.com/blog').must_equal result
  end

  it 'shovel method concatenates original string' do
    original_string = 'some string'
    id_of_original_string = original_string.object_id
    original_string << ' changed'
    original_string.must_equal 'some string changed'
    id_of_original_string.must_equal original_string.object_id
  end

  it 'shovel method turns a numeric object to a codepoint' do
    ''.<<(65).must_equal 'A' # 65 is ASCII 'A'
  end
end

describe 'Instance Methods group four' do
  it 'plus method does not affect original string' do
    original_string = 'some string'
    id_of_original_string = original_string.object_id
    new_string = original_string + ' changed'
    original_string.must_equal 'some string'
    id_of_original_string.must_equal original_string.object_id
    new_string.object_id.wont_equal original_string.object_id
  end

  it 'can compare by using <=> method,
      this method allows Comparable Module to be used' do
    first_string = 'A'
    second_string = 'B'
    third_string = 'A'
    first_string.<=>(third_string) .must_equal 0
    first_string.<=>(second_string).must_equal(-1)
    second_string.<=>(third_string) .must_equal 1
    ('a' <=> 'A').must_equal 1
  end

  it 'must be able to compare strings using ==' do
    a = 'string'
    (a == 'string').must_equal true
    ('b' == 'c').must_equal false
  end
end

describe 'Instance Methods group six' do
  before :each do
    @my_string = 'A test string with punctuation, and 1 2 3 numbers, and symbols such as @ or #. In the winter or summer.'
  end
  it 'must return the index or nil when =~ is used with a regex' do
    (@my_string =~ /3/).must_equal 40
    (@my_string =~ /z/).must_be_nil
  end

  it 'must reference an element or elements when used with []' do
    @my_string[0].must_equal 'A'
    @my_string[36..40].must_equal '1 2 3'
    @my_string[51, 3].must_equal 'and'
    @my_string['symbol'].must_equal 'symbol'
    @my_string['zebra'].must_be_nil
    # Need tests that show capture name or number for MatchData
    @my_string[/and/, 0].must_equal 'and'
  end

  it 'must manage lines' do
    text = 'lines\ngiven\n'
    ruby_version_is('2.0.0') do
      text.lines.must_be_kind_of Array
      text.lines.must_equal ['lines\ngiven\n']
    end
    ruby_version_is('1.9.3') do
      text.lines.must_be_kind_of Enumerator
    end
  end
end
# end

FORMAT = [
  ##  fields are:
  # format_code, value,   expected_result, failure comment
  ['b',    42,              '101010'],
  ['B',    42,              '101010'],
  %w[s string string],
  ['d',    42,              '42'],
  ['i',    42,              '42'], # Identical to d format code above
  ['u',    42,              '42'], # Identical to d format code above
  ['05d',  42,              '00042'],
  ['5d',   42,              '   42'],
  ['o',    42,              '52'], # convert to octal
  ['x',    42,              '2a'],
  ['X',    42,              '2A'],
  ['e',    42,              '4.200000e+01'],
  ['9.2e', 42,              ' 4.20e+01'],
  ['E',    42,              '4.200000E+01'],
  ['9.2E', 42,              ' 4.20E+01'],
  ['g',    42,              '42'],
  ['g',    42_123,          '42123'],
  ['9.2g', 42,              '       42'],
  ['9.2g', 42**-2,          '  0.00057', '42**-2'],
  ['9.2g', 42**-3,          '  1.3e-05', '42**-3'],
  ['9.2g', 42**2,           '  1.8e+03', '42** 2'],
  ['9.2G', 42**4,           '  3.1E+06', '42** 4'], # Hard to spot, but this capitalizes the E
  ['f',    42,              '42.000000'],
  ['.2f',  42,              '42.00'],
  ['.5a',  1,               '0x1.00000p+0'], # Figured this out.  Checkout 1024, it shows p as a binary to power of 10
  ['.5a',  1024,            '0x1.00000p+10']
].freeze

describe 'Formatting' do
  FORMAT.each do |format_code, value, result, comment|
    it "must format '%#{format_code}' % #{comment || value} to '#{result}'" do
      ("%#{format_code}" % value).must_equal result
    end
  end

  it 'can use named formatting arguments' do
    ('Name: %<name>s, $%<amount>.2f, Phone: %<phone>s' % { amount: 42,
                                                           phone: '555-1212',
                                                           name: 'Mom' }
    ).must_equal 'Name: Mom, $42.00, Phone: 555-1212'
  end
end

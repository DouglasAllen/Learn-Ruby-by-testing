require 'spec_helper'
require 'english'

describe 'Regular Expressions group one' do
  it 'must create a regex using forward slashes' do
    //.class.must_equal Regexp
  end

  it 'regexp using %r<delimiter><delimiter> syntax' do
    //.class.must_equal Regexp
  end

  it '123,456 must match digits with /\d/ with' do
    '123,456'.must_match(/\d/)
  end

  it 'must return the match location (index) with =~' do
    match_data = 'abc,123,456' =~ /\d/
    match_data.must_equal 4
    match_data = 'abc,def' =~ /c/
    match_data.must_equal 2
  end

  it 'global $~ a equals last MatchData object' do
    match_data = '123,456'.match(/\d/)
    $LAST_MATCH_INFO.must_equal match_data
  end
end

# From notes taken from James Edward Gray II's Regular Expression Study Notes
describe 'Regular Expressions group two' do
  it 'is delimited by /.../ by default' do
    //.class.must_equal Regexp
    /abc/.class.must_equal Regexp
  end

  it 'can be delimited by your choice using %r' do
    %r{<br/?>}.class.must_equal Regexp
    # %r!<br/?>!.class.must_equal Regexp rubocop notice
  end

  it 'used in an index for string to return match or nil' do
    'abc'[/a/].must_equal 'a'
    'James'[/a/].must_equal 'a'
    assert_nil('def'[/a/], nil)
  end

  it 'uses mode i to make case insensitive' do
    'abc'[/a/].must_equal 'a'
    assert_nil('ABC'[/a/], nil)
    'abc'[/a/i].must_equal 'a'
    'ABC'[/a/i].must_equal 'A'
  end
end

describe 'Regular Expressions group 3' do
  it 'character class matches first of included characters' do
    'abc'[/[aeiou]/].must_equal 'a'
    'James'[/[aeiou]/].must_equal 'a'
    'def'[/[aeiou]/].must_equal 'e'
    'abcdef'[/[aeiou]/].must_equal 'a'
    assert_nil('xyz'[/[aeiou]/], nil)
  end

  it 'negated character class uses the caret (^) character' do
    'abc'[/[^aeiou]/].must_equal 'b'
    'James'[/[^aeiou]/].must_equal 'J'
    'xyz'[/[^aeiou]/].must_equal 'x'
    assert_nil('aaa'[/[^aeiou]/], nil)
  end

  it 'can have Character classes with ranges' do
    'UPPER'[/[A-Z]/].must_equal 'U'
    assert_nil('aaa'[/[^aeiou]/], nil)
    assert_nil('lower'[/[A-Z]/], nil)
    'lower'[/[^A-Z]/].must_equal 'l'
    'lower'[/[a-z]/].must_equal 'l'
    'the number is 42'[/[0-9]/].must_equal '4'
    '3 blind mice'[/[A-Za-z0-9]/].must_equal '3'
  end
end

describe 'Regular Expressions group 4' do
  it 'escapes special characters with \ ' do
    'james@graysoftinc.com'[/inc\.com/].must_equal 'inc.com'
    assert_nil('james@graysoftinc-com'[/inc\.com/], nil)
    'a[1]'[/\[\d\]/].must_equal '[1]'
  end

  it 'Regexp.escape will provide escapes automatically' do
    Regexp.escape('d[ang]ero.us').must_equal 'd\\[ang\\]ero\\.us'
  end

  it 'allows for #{...} interpolation just like String' do
    @input = 'James'
    'James Edward Gray II'[/#{Regexp.escape(@input)}/i].must_equal 'James'
    'james@graysoftinc.com'[/#{Regexp.escape(@input)}/i].must_equal 'james'
    assert_nil('Dana Gray'[/#{Regexp.escape(@input)}/i], nil)
  end
end

describe 'Shortcut syntaxes for character classes' do
  it 'shortcut \d for 0-9 range' do
    'the number is 42'[/\d/].must_equal '4'
    assert_nil('abc'[/\d/], nil)
  end
end

describe 'Regular Expressions group 1' do
  it 'shortcut \D for negated 0-9' do
    'the number is 42'[/\D/].must_equal 't'
    'abc'[/\D/].must_equal 'a'
  end

  it 'shortcut \s for matching whitespace' do
    'space: '[/\s/].must_equal ' '
    "tab:\t"[/\s/].must_equal "\t"
    "newline:\n"[/\s/].must_equal "\n"
    assert_nil('nowhitespace'[/\s/], nil)
  end

  it 'shortcut \S for matching non-whitespace' do
    " \t\n word"[/\S/].must_equal 'w'
    assert_nil(" \t\n"[/\S/], nil)
  end

  it 'shortcut \w for [A-Za-z0-9]' do
    "\tword"[/\w/].must_equal 'w'
    "\tWord"[/\w/].must_equal 'W'
    '42 Word'[/\w/].must_equal '4'
    '_underscore'[/\w/].must_equal '_'
    assert_nil('! @ - # % ^ & * ( ) - + ='[/\w/], nil)
  end
end

describe 'Regular Expressions group 5' do
  it 'shortcut \W is negated [^A-Za-z0-9]' do
    '! @ - # % ^ & * ( ) - + ='[/\W/].must_equal '!'
    "\tword"[/\W/].must_equal "\t"
    assert_nil('word'[/\W/], nil)
  end

  it 'wildcard "." matches any char except new line' do
    'abc'[/a./].must_equal 'ab'
    'James'[/a./].must_equal 'am'
    'aa'[/a./].must_equal 'aa'
    'a(1)'[/a./].must_equal 'a('
    assert_nil('a'[/a./], nil)
    assert_nil("a\nb"[/a./], nil)
    "a\tb"[/a./].must_equal "a\t"
    'a b'[/a./].must_equal 'a '
  end
end

describe 'Repetition group one' do
  it 'wildcard "?" to make something optional' do
    '<br/>'[%r{<br/?>}].must_equal '<br/>'
    '<br>'[%r{<br/?>}].must_equal '<br>'
    assert_nil('<br//>'[%r{<br/?>}], nil)
    assert_nil('<br.>'[%r{<br/?>}], nil)
  end

  it 'wildcard "+" will match one or more' do
    # Use + to match one or more
    'the number is 42'[/\d/].must_equal '4'
    'the number is 42'[/\d+/].must_equal '42'
    'the number is 420'[/\d+/].must_equal '420'
    'the number is 420000'[/\d+/].must_equal '420000'
    'the number is 420000.00'[/\d+/].must_equal '420000'
    assert_nil('the number'[/\d+/], nil)
  end
end

describe 'Repetition group two' do
  it 'wildcard "*" will match zero or more' do
    # Use * to match zero or more
    'a'[/a*/].must_equal 'a'
    'aaa'[/a*/].must_equal 'aaa'
    'aaa '[/a*/].must_equal 'aaa'
    'aaa aa'[/a*/].must_equal 'aaa'
    'b'[/a*/].must_equal ''
    ''[/a*/].must_equal ''
  end

  it 'matches exact count with {n}' do
    '123456789'[/\d{3}/].must_equal '123'
    '123456789'[/\d{4}/].must_equal '1234'
    assert_nil('123456789'[/\d{10}/], nil)
  end

  it 'match between n and m with {n, m}' do
    '123456789'[/\d{2,4}/].must_equal '1234'
    '123'[/\d{2,4}/].must_equal '123'
    '12'[/\d{2,4}/].must_equal '12'
    assert_nil('1'[/\d{2,4}/], nil)
  end
end

describe 'Repetition group three' do
  it 'match at least n with {n, }' do
    # use {n,} to match at least n
    '123456789'[/\d{6,}/].must_equal '123456789'
    '123456789123456789'[/\d{6,}/].must_equal '123456789123456789'
    '123456'[/\d{6,}/].must_equal '123456'
    assert_nil('12345'[/\d{6,}/], nil)
  end

  it 'match up to m with {0,m}' do
    '123456789'[/\d{0,3}/].must_equal '123'
    '12'[/\d{0,3}/].must_equal '12'
    '1'[/\d{0,3}/].must_equal '1'
    ''[/\d{0,3}/].must_equal ''
  end
end

describe 'Finding and Replacing using sub and gsub with regexp' do
  before do
    @email = 'james@graysoftinc.com'
    @name = 'James Edward Gray II'
    @original_name = @name.clone
    @object_id = @name.object_id
  end

  it 'scan will get an array of all matches' do
    @email.scan(/[aeiou]/).must_equal %w[a e a o i o]
    @email.scan(/\W/).must_equal ['@', '.']
    @email.scan(/\s/).must_equal []
  end

  it 'sub is used to replace the first match' do
    @name.sub(/[aeiou]/i, 'X').must_equal 'JXmes Edward Gray II'
    @name.sub(/[a-z]/i, 'X').must_equal 'Xames Edward Gray II'
    @name.sub(/\d+/i, 'X').must_equal 'James Edward Gray II'
  end

  it 'gsub is used to globally replace matches' do
    @name.gsub(/[aeiou]/i, 'X').must_equal 'JXmXs XdwXrd GrXy XX'
    @name.gsub(/[a-z]/i, 'X').must_equal 'XXXXX XXXXXX XXXX XX'
    @name.gsub(/\d+/i, 'X').must_equal 'James Edward Gray II'
  end
end

describe 'Finding and Replacing using sub and gsub with regexp' do
  before do
    @email = 'james@graysoftinc.com'
    @name = 'James Edward Gray II'
    @original_name = @name.clone
    @object_id = @name.object_id
  end
  it 'bang method sub! alters the String' do
    @name.sub(/\w+/, 'X').wont_equal @name
    @name.must_equal @original_name
    @name.sub!(/\w+/, 'X').must_equal @name
    @name.object_id.must_equal @object_id
    @name.wont_equal @original_name
  end
  it 'bang method gsub! alters the string' do
    @name.gsub(/\w+/, 'X').must_equal 'X X X X'
    @name.must_equal @original_name
    @name.gsub!(/\w+/, 'X').must_equal 'X X X X'
    @name.object_id.must_equal @object_id
    @name.wont_equal @original_name
  end

  it 'blocks can be used for sub and gsub' do
    # sub() and gsub() can take a block for the replacement
    'james gray'.sub(/\w+/, &:capitalize).must_equal 'James gray'
    'james gray'.gsub(/\w+/, &:capitalize).must_equal 'James Gray'
    'james gray'.sub!(/\w+/, &:capitalize).must_equal 'James gray'
    'james gray'.gsub!(/\w+/, &:capitalize).must_equal 'James Gray'
  end
end

describe 'Anchors' do
  before do
    @email = 'james@graysoftinc.com'
  end

  it 'match at end of string with \z' do
    @email[/\w+\z/].must_equal 'com'
    'the number is 42.00'[/\d+\z/].must_equal '00'
    assert_nil(@email[/\d+\z/], nil)
  end

  it 'beginning of string match is \A' do
    @email[/\A\w+/].must_equal 'james'
    '3 blind mice'[/\A\d/].must_equal '3'
    assert_nil('the number is 42'[/\A\d/], nil)
  end

  it 'beginning of line matches with "^"' do
    "1 2 3\n4 5 6\n7 8 9".scan(/\A\d/).must_equal ['1']
    "1 2 3\n4 5 6\n7 8 9".scan(/^\d/).must_equal %w[1 4 7]
  end

  it 'end of line match is "$"' do
    "1 2 3\n4 5 6\n7 8 9".scan(/\d\z/).must_equal ['9']
    "1 2 3\n4 5 6\n7 8 9".scan(/\d$/).must_equal %w[3 6 9]
  end
end

describe 'Anchors' do
  before do
    @email = 'james@graysoftinc.com'
  end
  it 'word boundary match is "\b"' do
    '6 word boundaries'.gsub(/\b/, '!').must_equal '!6! !word! !boundaries!'
    'rubies escape James'.scan(/\w+es\b/).must_equal %w[rubies James]
    'Jimmy'[/Jim/].must_equal 'Jim'
    assert_nil('Jimmy'[/Jim\b/], nil)
    'Jim'[/Jim\b/].must_equal 'Jim'
  end

  it 'assignment can replace a regexp match' do
    @email[/\z/] = '>' # you can assign to replace a regular expression match
    @email.must_equal 'james@graysoftinc.com>'
    @email[/\A/] = '<'
    @email.must_equal '<james@graysoftinc.com>'
  end
end

describe 'Grouping' do
  it 'Uses {...} to group elements' do
    'y'[/\Ay(es)?\z/].must_match 'y'
    assert_nil('ye'[/\Ay(es)?\z/], nil)
    'yes'[/\Ay(es)?\z/].must_match 'yes'
    'Oh Haha!'[/(ha)+/i].must_match 'Haha'
    'Oh Hahaha!'[/(ha)+/i].must_match 'Hahaha'
    'Oh Hahahaaa!'[/(ha)+/i].must_match 'Hahaha'
  end
end

describe 'Alternation' do
  it 'multilple substitution patterns can be done with "|"' do
    'cat'[/[cbr]at/].must_match 'cat'
    'bat'[/[cbr]at/].must_match 'bat'
    'rat'[/[cbr]at/].must_match 'rat'
    'brat'[/[cbr]at/].must_match 'rat'

    'cat'[/br?at|[cr]at/].must_match 'cat'
    'bat'[/br?at|[cr]at/].must_match 'bat'
    'rat'[/br?at|[cr]at/].must_match 'rat'
    'brat'[/br?at|[cr]at/].must_match 'brat'

    'cat'[/(br?|[cr])at/].must_match 'cat'
    'bat'[/(br?|[cr])at/].must_match 'bat'
    'rat'[/(br?|[cr])at/].must_match 'rat'
    'brat'[/(br?|[cr])at/].must_match 'brat'

    result = *(0..21)
    (0..100).select { |n| n.to_s[/\A(2[01]|1?\d)\z/] }.must_equal result
  end
end

describe 'Capturing' do
  it 'captured groups can be accessed by number' do
    'James Gray'[/\A(\w+)\s+(\w+)\z/, 1].must_equal 'James'
    'James Gray'[/\A(\w+)\s+(\w+)\z/, 2].must_equal 'Gray'
    assert_nil('James Edward Gray'[/\A(\w+)\s+(\w+)\z/, 1], nil)
  end

  it 'captures count from the opening or left parenthesis' do
    'james@graysoftinc.com'[/\A(\w+)@((\w+)\.(\w+))\z/, 1].must_equal 'james'
    assert_equal('james@graysoftinc.com'[/\A(\w+)@((\w+)\.(\w+))\z/, 2],
                 'graysoftinc.com')
    assert_equal('james@graysoftinc.com'[/\A(\w+)@((\w+)\.(\w+))\z/, 3],
                 'graysoftinc')
    'james@graysoftinc.com'[/\A(\w+)@((\w+)\.(\w+))\z/, 4].must_equal 'com'
  end

  it '$1 and $2 globals can access matches' do
    # Captures can also be accessed in sub()/gsub() replacement Strings or
    # with $1, $2, ... variables after a match
    'James Gray'.sub(/\A(\w+)\s+(\w+)\z/, '\2, \1').must_equal 'Gray, James'
    'James Gray'.sub(/\A(\w+)\s+(\w+)\z/) do
      "#{Regexp.last_match(2)}, #{Regexp.last_match(1)}"
    end.must_equal 'Gray, James'
  end
end

describe 'Match Operators' do
  it 'matches can also be tested by "=~"' do
    ('42' =~ /\A\d+\z/).must_equal 0
    assert_nil(('42.00' =~ /\A\d+\z/), nil)
  end

  it 'matches are negated as well by "!~"' do
    ('42.00' !~ /\A\d+\z/).must_equal true
    ('42' !~ /\A\d+\z/).must_equal false
  end
end

require_relative 'spec_helper'

describe 'random number from a range' do
  if ruby_version_is('2.0.0') || ruby_version_is('1.9.3')
    it 'must return a random number from a range' do
      original_srand = srand

      Random.srand(48_061)
      rand(1..1_000_000).must_equal 283_107
      rand(1...9).must_equal 3
      # restore the random seed
      Random.srand(original_srand)
    end
  end
end

describe 'creating Hashes from arrays' do
  it 'must take an array of arrays, and create Hashes' do
    names = %w[Mary Moe Fred Francine Joey]
    ages = [23, 43, 39, 27, 25]
    Hash[names.zip(ages)].must_equal(
      'Mary' => 23, 'Moe' => 43, 'Fred' => 39, 'Francine' => 27, 'Joey' => 25
    )
  end
end

describe 'prepending strings' do
  it 'must prepend a string in various ways' do
    string = 'World!'
    string.insert(0, 'Hello ').must_equal 'Hello World!'
    string.must_equal 'Hello World!'
    unless ruby_version_is?('1.9.2')
      string.prepend('Yes. ').must_equal 'Yes. Hello World!'
    end
  end
end

describe 'regular expression as a way to dynamically make variabless' do
  it 'must create first_name and last_name variables when matched' do
    string = 'Mary Jane'
    /(?<first_name>\w+) (?<last_name>\w+)/ =~ string
    first_name.must_equal 'Mary'
    last_name.must_equal 'Jane'
  end
  it 'must create variables, but holding values of nil if regexp does not match' do
    string = 'Mary'
    /(?<first_name>\w+) (?<last_name>\w+)/ =~ string
    first_name.must_be_nil
    last_name.must_be_nil
  end
end

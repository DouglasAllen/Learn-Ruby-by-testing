require 'spec_helper.rb'
#doc
module Helpers
  def foo(other = nil)
    "bar #{(other || 'works')}"
  end
end
include Helpers

describe Proc do
  it 'must initialize Proc object by stabby lambda syntax' do
    my_lambda = -> {}
    my_lambda.class.must_equal Proc
  end
  it 'must initialize Proc object by using lambda {} syntax' do
    my_lambda = -> {}
    my_lambda.class.must_equal Proc
  end
  it 'accepts an argument using lambda syntax' do
    my_lambda1 = ->(argument) do; argument; end
    my_lambda2 = ->(arg) { arg * 2 }
    my_lambda1[3]          .must_equal 3
    my_lambda1['something'].must_equal 'something'
    my_lambda2[21]         .must_equal 42
    my_lambda2['Hello']    .must_equal 'HelloHello'
  end

  it 'accepts an argument using stabby lambda' do
    my_lambda = ->(arg) { arg * 3 }
    { 'Hi' => 'HiHiHi', 7 => 21 }.each do |arg, answer|
      my_lambda[arg].must_equal answer
    end
  end

  it 'raises for lambda with wrong number of arguments' do
    my_lambda = ->(arg) {}
    my_lambda.must_raise ArgumentError
  end

  it 'Proc does not check argument arity' do
    my_proc = proc { |arg| }
    my_proc[1, 2, 3] # there is no 'wont_raise' just run the code!
  end

  it 'must be able to convert a method to a proc' do
    my_foo = Helpers.method(:foo).to_proc
    my_foo.class.must_equal Proc
    my_foo[].must_equal 'bar works'
    my_foo['is foo'].must_equal 'bar is foo'
  end

  describe '#source_location' do
    before do
      my_proc = proc {}
      @location = my_proc.source_location
    end

    it 'must return an array of two elements' do
      @location.must_be_kind_of Array
      @location.size.must_equal 2
    end

    it 'must be a string that describes a path' do
      @location[0].must_be_kind_of String
      @location[0].must_include '/'
    end

    it 'must give a line number' do
      @location[1].must_be_kind_of Numeric
    end
  end
end

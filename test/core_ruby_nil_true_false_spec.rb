require 'spec_helper'

describe NilClass do
  methods_that_require_no_argument_and_exepcted_result = {
    inspect: 'nil',
    nil?: true,
    rationalize: (0/1),
    to_a: [],
    to_c: Complex(0),
    to_f: 0.0,
    to_i: 0,
    to_r: (0/1),
    to_s: '',
  }

  methods_that_require_an_argument_and_expected_result = {
    #  Method => argument, expected result and optional notes in comments
    :& => ['', false], # obj is always evaluated as it is the argument to a method call.  No short-circuit evaluation
    :& => [false, false],
    :& => [nil, false],
    :^ => [true, true],
    :^ => [false, false],
    :| => [nil, false],
    :| => [false, false],
    :| => [true, true],
  }

  methods_that_require_no_argument_and_exepcted_result.each_pair do |method, answer|
    it "nil.#{method} -> #{answer.inspect}" do
      nil.send(method).must_equal answer
    end

  end

  ruby_version_is '2.0.0' do
    it '2.0.0 and later: .to_h returns empty Hash' do
      nil.to_h.must_equal {}
    end
  end

  describe 'methods that require an argument' do

    methods_that_require_an_argument_and_expected_result.each_pair do |method, obj_and_answer|
      obj, answer = obj_and_answer
      it "nil.#{method}(#{obj}) -> #{answer.inspect}" do
        nil.send(method, obj).must_equal answer
      end
    end
  end
end


describe TrueClass do

end

describe FalseClass do

end

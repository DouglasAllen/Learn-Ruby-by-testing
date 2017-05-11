
require 'spec_helper'

describe 'deconstruct these tidbits' do
  it '!?! must be false' do
    answer = !'!'
    answer.must_equal false
  end
  it '!!?! must be true' do
    answer = !!'!'
    answer.must_equal true
  end
  it '?:??::?? must be ":"' do
    answer = ':' ? ':' : '?'
    answer.must_equal ':'
  end
end

describe 'Deprecate methods in Ruby' do
  load 'assets/deprecated_method.rb'
  it 'raises a warning when deprecated' do
    deprecated_method = -> { deprecated }
    # must_output(stdout, stderr)
    deprecated_method.must_output(nil, "This method is deprecated\n")
  end
end

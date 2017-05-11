require 'spec_helper'

describe Enumerable do
  it 'must inject or reduce collections' do
    my_collection = (5..10)
    45.must_equal my_collection.inject(:+)
    45.must_equal my_collection.inject(0, :+)
    46.must_equal my_collection.inject(1, :+)
    10.must_equal(
      my_collection.inject {|memo,number| number > memo ? number : memo }
    )
  end
end

require 'spec_helper'

describe Hash do
  before do
    @grades = { A: 12, B: 9, C: 6, D: 3, F: 1 }
  end
  it 'must set default of 0 with Grades.default = 0' do
    @grades.default = 0
    [1, 2, :I, 'F'].each do |grade|
      @grades[grade].must_equal 0
    end
  end
  it 'must be able to pull key value pairs by assoc method' do
    @grades.assoc(:D).must_equal [:D, 3]
  end
  it 'must clear the hash using clear' do
    @grades.clear.must_equal({})
  end
  it 'must be able to create a hash from an array' do
    Hash[:a, 12, :b, 9, :c, 6, :d, 3].must_equal(
      a: 12, b: 9, c: 6, d: 3
    )
  end
  it 'can use a default proc' do
    @grades.default_proc = ->(h, k) do
      h[k] = { time: Time.now, callee: __callee__, file: __FILE__ }
    end
    @grades[1].keys.must_include :time
  end
end

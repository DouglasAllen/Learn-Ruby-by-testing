require 'spec_helper'

describe 'BuiltIn Stuff' do

  it '!nil should be true' do
    answer = !nil
    answer.must_equal true
  end
  it '!!nil should make nil be a boolean false' do
    answer = !!nil
    answer.must_equal false
  end
  it '!!"something truthy" should be true' do
    answer = !!(1+1)
    answer.must_equal true
  end
  it '!() returns true' do
    answer = !()
    answer.must_equal true
  end
  it 'can be used as a true/false operator with regexp' do
    answer = !!'123'.match(/\A[1-9][0-9]*\z/)
    answer.must_equal true
    answer = !!'abc'.match(/\A[1-9][0-9]*\z/)
    answer.must_equal false
  end


end

describe 'Less used stuff' do
  it 'flip-flop operator' do
    flip_flop = proc { |num| true if num==3..num==5 }
    3.upto(5) do |x|
      flip_flop[x].must_equal true
    end
    6.upto(10) do |x|
      assert_nil(flip_flop[x], nil)
    end
  end
end

__END__
Things to test here:

* !
* !!
* not
* and
* or
* ||
* &&
* =
* ::
* []
* **
* |
* &
* <=> -- --- != =~ !~
* The unary operators
* !
* -
* +
* ~
* ? : (Ternary operator)

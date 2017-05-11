require 'spec_helper'

describe 'Core Behavior' do
  describe Integer do
    it 'Binary numbers are Fixnums' do
      0b0001.must_be_kind_of(Integer)
    end

    it 'must be an absolute value when abs is used on it' do
      message = 'abs means no polarity on the number'
      -15.abs.must_equal 15, message
      15.abs.must_equal 15, message
    end

    it 'must have magnitude which is an alias for abs' do
      -42.abs.must_be_same_as(
        -42.magnitude, 'magnitude and abs are alias and so must be identical')
    end

    it 'must divide in an Integer style' do
      9.div(5).must_equal 1, '9 divided by 5 should be 1'
      8.div(2).must_equal 4, '8 divided by 2 should be 4'
      7.div(4).must_equal 1, '7 dividided by 4 should be 1'

      15.upto(20) do |numerator|
        2.must_equal numerator.div(7), "#{numerator}.div 7 must be 2"
      end

      -15.downto(-21) do |numerator|
        -3.must_equal numerator.div(7), "#{numerator}.div 7 must be -3"
      end

      15.upto(21) do |numerator|
        -3.must_equal numerator.div(-7), "#{numerator}.div -7 must be -3"
      end

      -14.downto(-20) do |numerator|
        2.must_equal numerator.div(-7), "#{numerator}.div -7 must be 2"
      end
    end

    it 'must return the next number with succ' do
      -9.upto(9) do |number|
        (number + 1).must_equal number.succ
      end
    end

    it 'must report zero accurately' do
      [-1, -0.5, 0, 0.5, 1].map(&:zero?).must_equal(
        [false, false, true, false, false]
      )
    end

    it 'Bitwise Exclusive OR' do
      # 7 ^ 4 in binary
      # 0111
      # 0100 ^
      # 0011 =
      (7 ^ 4).must_equal 3
      (0b0111 ^ 0b0100).must_equal 0b0011
      (-1 ^ 1).must_equal(-2)
      (-0b0001 ^ 0b0001).must_equal(-0b0010)
    end

    it 'The ~ (tilde) operator' do
      # The compliment where each bit is flipped
      (~0b0010).must_equal(-3)
      (~0b0001).must_equal(-2)
    end

    it 'converts number bases with to_s' do
      2.upto(36) do |x|
        1.to_s(x).must_equal '1'
      end
    end
    it 'number bases must be between 2 and 36, inclusively' do
      [37, 0, 1, -1].each do |base|
        check_base_lambda = proc { 1.to_s(base) }
        check_base_lambda.must_raise ArgumentError
      end
    end
  end
end

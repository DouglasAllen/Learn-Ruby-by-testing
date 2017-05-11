require 'spec_helper'

Struct.new('Point', :x, :y)
Struct.new('Array', :x, :y)

describe Struct do
  describe 'Namespacing' do
    it 'must contain the class Point' do
      Struct.constants.must_include :Point
    end

    it 'must return an array Struct' do
      Struct.constants.must_include :Array
    end

    it 'must accept a string or a symbol as a method name' do
      my_struct = Struct.new('Point2', 'string_method', :x_method)
      my_struct.instance_methods.must_include :string_method
      my_struct.instance_methods.must_include :x_method
    end

    it 'must never equal for two different structs even with same members' do
      Struct::Point.wont_equal Struct::Array
    end
  end

  describe 'Instance Methods' do
    before :each do
      @my_struct_instance = Struct::Point.new(1, 5)
      @my_struct2 = Struct::Array
    end

    it 'adds a new attribute to existing Struct' do
      @my_struct_instance.send(:y)
      @my_struct_instance.must_respond_to :y
    end

    it 'must return a hash if to_h is called ' do
      @my_struct_instance.to_h.must_equal(x: 1, y: 5)
    end

    it "two instances of different structs must never
        equal even if members and values are the same" do
      first  = @my_struct2.new(1, 5)
      second = @my_struct_instance
      first.wont_equal second
    end

    it 'must return values if calling to_a on a struct instance' do
      @my_struct_instance.to_a.must_equal [1, 5]
    end

    it 'must be able to reassign attribute using []' do
      @my_struct_instance[:x] = 15
      @my_struct_instance.x.must_equal 15
    end

    it 'must return members and values if calling each_pair ' do
      @my_struct_instance.each_pair.map do |k, v|
        [k, v]
      end.flatten.must_equal [:x, 1, :y, 5]
    end

    it "two instances of the same structs are equal if members and
    values are the same" do
      first  = @my_struct2.new(1, 5)
      second = @my_struct2.new(1, 5)
      first.must_equal second
    end

    it 'Struct instance must have a fixed fields' do
      actual1 = -> { @my_struct2.new(1, 5, 7) }
      actual2 = -> { @my_struct2.new(1, 5, 7, 8) }
      actual1.must_raise ArgumentError
      actual2.must_raise ArgumentError
    end

    it 'must raise NoMethodError if calling unknown attribute' do
      -> { @my_struct_instance.a }.must_raise NoMethodError
    end
    it 'must not raise error if given no arguments' do
      @my_struct2.new.x.must_be_nil
    end

    it 'accepts a block as a class body' do
      my_struct = Struct.new('AcceptBlockMethod', :a, :b) do
        def block_method; end
      end
      my_struct.new(15, 51).must_respond_to :block_method
    end

    it 'must be able to list the methods' do
      @my_struct_instance.members.must_equal %i[x y]
    end

    it 'must create a Struct with a symbol' do
      @my_struct_instance.to_h.must_equal(x: 1, y: 5)
    end

    it 'must respond to each' do
      Struct::Array.allocate.must_respond_to :each
    end

    it 'must iterate for each attribute with each' do
      -> { @my_struct_instance.each { |point| puts point } }.must_output "1\n5\n"
    end

    it 'must report size when size is called' do
      @my_struct_instance.size.must_equal 2
    end

    it 'must return the members of struct as symbols' do
      @my_struct_instance.members.must_equal %i[x y]
    end
  end
end

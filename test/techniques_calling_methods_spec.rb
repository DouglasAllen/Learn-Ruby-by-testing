require 'spec_helper'

class Klass
  public

  def my_public_method
    'my public method'
  end

  protected

  def my_protected_method
    'my protected method'
  end

  private

  def my_private_method
    'my private method'
  end

  def method_missing(name, *args)
    if name == :my_private_method
      raise NoMethodError
    else
      "#{name} called with #{args} arguments"
    end
  end
end

describe 'We must set up a method missing for testing' do
  it 'must call method_missing if unknown method' do
    proc { Klass.new.boogah }[].must_equal 'boogah called with [] arguments'
  end
end

describe 'You can call methods the following ways' do
  it 'must call private method called my_private_method' do
    Klass.new.send(:my_private_method).must_equal 'my private method'
  end
  it 'must raise NoMethodError if you attempt to call a private method' do
    proc { Klass.new.my_private_method }.must_raise NoMethodError
  end
  it 'must call public methods by calling on object using dot' do
    Klass.new.my_public_method.must_equal 'my public method'
  end
  it 'must be able to call a private method when we use the method method' do
    Klass.new.method(:my_private_method).call.must_equal 'my private method'
  end
end

describe 'Method method creates a Method object' do
  it 'must ignore access restrictions using method' do
    Klass.new.method(:my_private_method).class.must_equal Method
    my_extracted_private_method = Klass.new.method(:my_private_method)
    my_extracted_private_method.call.must_equal 'my private method'
    my_extracted_private_method[].must_equal 'my private method'
  end
  it 'will raise NameError for created methods' do
    proc { Klass.new.method(:boogah) }.must_raise NameError
  end
end

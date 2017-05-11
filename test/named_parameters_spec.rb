require 'spec_helper'

if ruby_version_is '2.2.2'
  describe 'Named Parameters' do
    it ' npositional argument default' do
      hello.must_equal 'Hello World!'
    end
    it ' npositional argument' do
      hello('Folks').must_equal 'Hello Folks!'
    end
    it ' naccept a named argument' do
      hello(name: 'Folks').must_equal 'Hello Folks!'
    end
    it ' noverrides a positional argument' do
      hello('peanuts', name: 'Folks').must_equal 'Hello Folks!'
    end
  end
end

def hello(_name = 'World', name: _name)
  "Hello #{name}!"
end

require 'spec_helper'

describe 'bsearch for Array' do
  before :each do
    @ary = [0, 4, 7, 10, 12]
  end
  if ruby_version_is '2.0.0'
    it 'bsearch greater than 4 will return 4 as it is the found target' do
      @ary.bsearch {|x| x >= 4 }.must_equal 4
    end
    it 'bsearch greater than or equal to 6' do
      @ary.bsearch {|x| x >= 6 }.must_equal 7
    end
    it 'bsearch -1 must return 0 as it is the first thing greater than -1 ' do
      @ary.bsearch {|x| x >=  -1 }.must_equal 0
    end
    it 'bsearch greater than 100 will return nil for no target found' do
      @ary.bsearch {|x| x >= 100 }.must_equal nil
    end
  end
end

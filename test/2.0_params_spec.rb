require 'spec_helper'

# This following if statement avoids syntax checking which would
# fail if it were present here, and so we conditionally require it
if ruby_version_is '2.0.0'
  require 'assets/2.0.0_specific_assets'
  include AssetsFor2_0
end

describe 'Named Parameters for 2.0.0' do
  if ruby_version_is('2.0.0')

    it 'methods take the named parameters' do
      some_method(
        1, 2, 'three',
        occupation: 'programmer',
        phone: '123-456-7890',
        name: 'Jane').must_equal(
          'Jane,
          42,
          glob of arguments =
          [1, 2, "three"] other params {occupation: "programmer",
          :phone=>"123-456-7890"}'
          )
    end

    it 'Procs also use the named parameters' do
      AssetsFor2_0::My_2_0_proc.call(
        occupation: 'Rubyist',
        name: 'Jane').must_equal ['Jane', 42, occupation: 'Rubyist']
    end

  end
end

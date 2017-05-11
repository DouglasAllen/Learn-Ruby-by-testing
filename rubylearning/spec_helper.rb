
# This will load the requirements as we go along
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/matchers'

# To select a different reporter copy the spec/spec_config.rb.example to
# spec/spec_config.rb and select the reporter you wish to use.
if ENV['REPORT']
  Option = { report_style: ENV['REPORT'] }.freeze
elsif File.exist?('./test/spec_config.rb')
  require('./test/spec_config')
else
  Option = { report_style: 'Default' }.freeze
end

MiniTest::Reporters.use!(
  instance_eval("MiniTest::Reporters::#{Option[:report_style]}Reporter.new"))

def ruby_version_is(version_string)
  return block_given? ? yield : true if version_string == RUBY_VERSION
end

alias ruby_version_is? ruby_version_is

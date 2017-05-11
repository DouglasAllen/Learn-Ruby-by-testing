require 'spec_helper'

def report
  'output some kind of report'
end

describe 'spec matchers' do
  it 'must_match the return' do
    report.must_match 'some'
  end

  it 'must_output matches output to STDOUT or STDERR using lambda' do
    -> {print report}.must_output 'output some kind of report'
  end
end


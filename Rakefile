require 'rdoc/task'
require 'rake/testtask'

task default: [:test]
Rake::TestTask.new(:test) do |t|
  t.libs = ['test']
  t.warning = true
  t.verbose = false
  t.test_files = FileList['test/*_spec.rb'] + FileList['test/test_*.rb']
end

Rake::RDocTask.new do |rd|
  rd.main = 'README.markdown'
  rd.rdoc_files.include('README.markdown', 'lib/**/*.rb')
end

require 'rake/testtask'

require "./app"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc "daily cron for updating"
task :cron do
  BlackWidow.new.bite
end

desc "fix wrong date"
task :fix_date do
  Matter.all(:date => "-4712-01-01").update(:date => Date.today.prev_day)
end

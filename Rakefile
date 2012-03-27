require 'bundler'
Bundler.require

require "./app"

desc "daily cron for updating"
task :cron do
  BlackWidow.new.bite
end

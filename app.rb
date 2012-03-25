$:.unshift File.join(File.dirname(__FILE__), 'lib')

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db.db")

require 'matter'

class App < Sinatra::Base

  get '/' do
    'booting...'
  end
end

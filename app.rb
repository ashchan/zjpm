$:.unshift File.join(File.dirname(__FILE__), 'lib')

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db.db")
require 'matter'
DataMapper.finalize

require 'black_widow'

class App < Sinatra::Base

  get '/' do
    @matters = Matter.latest
    erb :index
  end

  post '/scrape' do
    BlackWidow.new.bite
    "scraped"
  end
end

require 'bundler'
Bundler.require

$:.unshift File.join(File.dirname(__FILE__), 'lib')

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db.db")
require 'matter'
DataMapper.finalize

require 'black_widow'
require 'helpers'

class App < Sinatra::Base
  helpers Helpers

  get '/' do
    @matters = Matter.latest
    erb :index
  end

  get '/:city' do
    @matters = Matter.all(
      :city => params[:city],
      :order => [:date.desc],
      :limit => 30
    ).reverse
    erb :city
  end

  post '/scrape' do
    BlackWidow.new.bite
    "scraped"
  end
end

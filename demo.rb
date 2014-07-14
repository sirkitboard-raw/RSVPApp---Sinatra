require 'sinatra'
require 'haml'
require 'data_mapper'

class Item
  include DataMapper::Resource
  property :name, String, :key => true
  property :nopeople, Integer
  property :phno, String
  property :email, String
end

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/demo.db")
  DataMapper.finalize
  DataMapper.auto_migrate!
end

get '/' do
  @demo = Item.all
  p @demo
  haml :view
end

post '/' do
  params.each do |y|
    puts y
  end
  @demo = Item.new params
  if @demo.save
    "success!"
  else
    "fail! #{@results.errors.to_s}"
  end
end


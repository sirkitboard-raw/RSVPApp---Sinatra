require 'sinatra'
require 'haml'
require 'data_mapper'

class Item
  include DataMapper::Resource
  propery :id, Serial, :key => true
  property :name, String,
  property :nopeople, Integer
  property :phno, String
  property :email, String
  property :created_at, DateTime
end

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/demo.db")
  DataMapper.finalize
  DataMapper.auto_migrate!
end

get '/' do
  @demo = Item.all
  p @demo
  erb:home
end

post '/' do
  params.each do |y|
    puts y
  end
  demo = Item.new
  demo.name = params[:name]
  demo.phno = params[:phno]
  demo.nopeople = params[:nopeople]
  demo.email = params[:email]
  demo.created_at = Time.now
  if demo.save
    "success!"
  else
    "fail! #{@results.errors.to_s}"
  end
end


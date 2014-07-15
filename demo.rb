require 'sinatra'
require 'haml'
require 'data_mapper'

class Item
  include DataMapper::Resource
  property :id, Serial, :key => true
  property :name, String
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
  erb :home
end

get '/:id' do
  demo = Item.get params[:id]
  p @demo
  erb :view
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
    redirect '/'
  else
    redirect '/'
  end
end

delete '/:id' do
  n = Item.get params[:id]
  n.destroy
  redirect '/'
end

get '/:id/delete' do
  @demo = Item.get params[:id]
  erb :delete
end


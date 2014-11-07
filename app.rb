require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'pry'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/plog.db")

class Post
  include DataMapper::Resource
  property :name, Serial
  property :email, String
  property :password, String
end
DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
Post.auto_upgrade!
 
#get '/' do
  # get the latest 20 posts
  #@posts = Post.all(:order => [ :id.desc ], :limit => 20)
  #erb :about
#end
#get '/' do
 # "Bonjour Simplon "
  #erb :/about 
#end
get '/' do
  @title ="entrer le text"
  erb :about
end

post '/about' do
  newpost = Post.new(name: params[:name], email: params[:email], password: params[:password])
  newpost.save

  redirect to '/'
end

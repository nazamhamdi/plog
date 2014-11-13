require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'pry'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/plog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :message,String
  property :created_at, DateTime
end
DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
Post.auto_upgrade!
Time.now.strftime('%d %m  %Y %H:%M')

 
#get '/' do
  # get the latest 20 posts
  @posts = Post.all(:order => [ :id.desc ], :limit => 20)
  #erb :about
#end
get '/' do
  @title = Post.all(:order => [ :id.desc ], :limit => 20)
  erb :about
end

post '/about' do
  #newpost = Post.new(name: params[:name],message: params[:message])
  #newpost.save
  
   erb :about
end

get '/new' do
   erb :new
  
end

post '/new' do
  message = Post.create(params[:post])
  redirect '/'
end 
#### Modifier L'un des logs####
get 'posts:id' do |id|
@post = Post.get(id)
erb :edit
end
put '/posts/:id' do |id|
post = Post.get(id)
success = post.update!(params[:post])
if success
redirect "/"
else
redirect "/posts/#{id}"
end
end
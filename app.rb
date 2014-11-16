require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'pry'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/plog.db")

#######Définition d'une classe Post#######
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
#########Définition des routes##########
get '/' do
  @title = Post.all(:order => [ :id.desc ], :limit => 20)
  erb :about
end
post '/about' do
  newpost = Post.new(name: params[:name],message: params[:message])
  newpost.save
   erb :about
end

#####################################
####Creation d'un nouveau message####
#####################################
get '/new' do
   erb :new
end
post '/new' do
  message = Post.create(params[:post])
  redirect '/'
end 

###########################
####Modifier un message####
###########################
get '/edit/:id' do |id|
  @post = Post.get(id)
  erb :edit
end

put '/posts/:id' do |id|
  modif = Post.get(id)
  success = modif.update!(params[:post])
  if success
    redirect "/"
  else
    redirect "/edit/#{id}"
  end
end
############################
####Supprimer un message####
############################
get '/del/:id' do |id|
  @post = Post.get(id)
  erb :del 
end
delete '/posts/:id' do |id|
@post = Post.get!(id)
@post.destroy!
redirect "/"
end
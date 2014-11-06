require 'sinatra'

get '/about' do
  erb :about
end
get '/' do
  "Hello World"
end
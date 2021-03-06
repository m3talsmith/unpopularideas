require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'mongo'
require 'mongoid'

# Want a social network where you can talk about popular topics online? Then go sign up for reddit.
# Need a place to post your unpopular ramblings that no one wants to listen to? You're in the right place.

configure do
  Mongoid.load!('mongoid.yml')
end

class Idea
  include Mongoid::Document
  field :name
  validates_uniqueness_of :name
  validates_presence_of :name
end
#== STATIC HTTP SERVER STUFF ==

get 'favicon.ico' do
end

get '/:dir/:file' do
  # "Please sir, I want some more nested resources"
  # One level deep! That's all you get!
  File.open("#{params[:dir]}/#{params[:file]}").readlines
end

get '/' do
  File.open("index.html").readlines
end


#== RESTFUL API STUFF ==
#=== CRUD ===

post '/ideas' do
  #create
  request_body = JSON.parse(request.body.read.to_s)
  Idea.create(name: request_body['title'])
  binding.pry
end

get '/ideas' do
  #WARNING: THIS IS A TEMPORARY STUB!!!
  #read (all)
    content_type 'application/json'
    Idea.all.limit(10).to_json
end

put '/ideas' do
  #update
    binding.pry
end

delete '/ideas/:id' do
  #destroy
    Idea.find(params[:id]).destroy
end
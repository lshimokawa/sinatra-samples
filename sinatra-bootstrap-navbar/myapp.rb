require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  erb :index
end

get '/page1' do
  erb :page1
end

get '/page2' do
  erb :page2
end

get '/page3' do
  erb :page3
end
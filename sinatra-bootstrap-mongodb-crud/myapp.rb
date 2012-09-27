require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongodb'

class Task
  include Mongoid::Document

  field :title, type: String
  field :body, type: String
end

get '/' do
  erb :hello
end
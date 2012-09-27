require 'bundler/setup'
Bundler.require(:default)

require File.dirname(__FILE__) + "/myapp.rb"

map '/' do
  run CORE::Main
end
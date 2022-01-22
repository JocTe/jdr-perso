require "sinatra"
require 'rubygems'
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/character'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @characters = Character.all

  erb :index, layout: :layout
end

get '/characters/:name' do
  # db_array = DB.execute("SELECT * FROM characters WHERE name = ?", params[:name]).flatten
  # cols = ["name", "type", "description", "age", "height", "weight", "sex","origin" ]
  @character = Character.find_by(name: params[:name])
  # @character = cols.zip(db_array[1..-1]).to_h.transform_keys(&:to_sym)
  erb :show, layout: :layout
end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end

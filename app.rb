require "sinatra"
  require "sinatra/reloader" if development?
  require "pry-byebug"
  require "better_errors"
  require "sqlite3"
  require 'sinatra/activerecord'
  require 'active_support/core_ext'

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

class App < Sinatra::Base

  current_dir = Dir.pwd
  Dir["#{current_dir}/models/*.rb"].each { |file| require file }


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
end

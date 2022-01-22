require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "sqlite3"

DB = SQLite3::Database.new(File.join(File.dirname(__FILE__), 'db/jdr.sqlite'))

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @characters = DB.execute("SELECT name FROM characters").flatten
  erb :index, layout: :layout
end

get '/characters/:name' do
  db_array = DB.execute("SELECT * FROM characters WHERE name = ?", params[:name]).flatten
  cols = ["name", "type", "description", "age", "height", "weight", "sex","origin" ]
  @character = cols.zip(db_array[1..-1]).to_h.transform_keys(&:to_sym)
  erb :show, layout: :layout
end

require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'

namespace :db do
  task :seed do
    seed_file = File.join('db/seeds.rb')
    load(seed_file) if File.exist?(seed_file)
  end
end

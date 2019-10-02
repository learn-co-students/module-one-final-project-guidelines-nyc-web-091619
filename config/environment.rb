require 'bundler'
require "sinatra/activerecord"
require 'pry'
require "tty-prompt"
require "csv"


Bundler.require
require_all 'lib'

prompt = TTY::Prompt.new
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')



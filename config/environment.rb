require 'bundler/setup'
Bundler.require


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/pslapp.sqlite')
require_all 'lib'

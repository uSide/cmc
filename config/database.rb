require 'sequel'
require 'logger'

loggers = []
loggers.push(Logger.new($stdout)) unless ENV.fetch('APP_ENV') != 'test'
Database = Sequel.connect(ENV.fetch('DATABASE_URL'), loggers: loggers)

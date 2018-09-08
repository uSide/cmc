require 'sequel'

Database = Sequel.connect(ENV.fetch('DATABASE_URL'))

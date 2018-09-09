require 'dotenv'
env = ENV.fetch('APP_ENV') { 'development' }
Dotenv.load(File.dirname(__FILE__) + "/../.env.#{env}")

require_relative 'database'
require 'dry-transaction'
require 'dry-validation'
require 'dry-matcher'
require 'rainbow'
require 'faraday'
require 'oj'
require 'slim'

# load app
Dir[File.dirname(__FILE__) + '/../app/**/*.rb'].each { |file| require(file) }

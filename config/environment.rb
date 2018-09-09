require 'dotenv'
env = ENV.fetch('APP_ENV') { 'development' }
ENV.store('APP_ENV', env)
Dotenv.load(File.dirname(__FILE__) + "/../.env.#{env}")

require_relative 'database'
require 'dry-transaction'
require 'dry-validation'
require 'dry-matcher'
require 'rainbow'
require 'faraday'
require 'oj'
require 'slim'
require 'r18n-core'

R18n.default_places = './config/locales/'

# load app
Dir[File.dirname(__FILE__) + '/../app/**/*.rb'].each { |file| require(file) }

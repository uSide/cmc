require 'dotenv/load'
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

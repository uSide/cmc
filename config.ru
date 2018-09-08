require_relative 'config/environment'
require 'rack/router'

router = Rack::Router.new do
  get '/' => ->(env) { CurrenciesController.new(env).index }
  post '/' => ->(env) { CurrenciesController.new(env).update }
end

app = Rack::Builder.new do
  use Rack::Static,
      urls: ['/img', '/js', '/css', '/favicon.ico'],
      root: 'public'

  run(router)
end

Rack::Handler.default.run(app, Host: ENV.fetch('BIND') { '0.0.0.0' },
                               Port: ENV.fetch('PORT') { 3000 })

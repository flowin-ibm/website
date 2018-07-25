require 'roda'

class App < Roda
  use Rack::Session::Cookie, secret: 'call4c0de'

  plugin :flash
  plugin :h
  plugin :render, escape: true
  plugin :static, ['/js', '/css']

  route do |r|
    # GET / request
    r.root do
      view :home
    end

    # All routes starting with /hello
    r.on 'hello' do
      # Set variable for all routes in /hello
      @greeting = 'Hello'

      # GET /hello/world
      r.get 'world' do
        "#{@greeting} world!"
      end

      # just /hello
      r.is do
        # GET /hello
        r.get do
          "#{@greeting}!"
        end

        # POST /hello
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end
  end
end

run App.freeze.app

require 'roda'
require 'forme'
require 'rest-client'
require 'json'

Hotspot = Struct.new(:name, :latitude, :longitude, :status, keyword_init: true)

class App < Roda
  use Rack::Session::Cookie, secret: 'call4c0de'

  plugin :flash
  plugin :forme
  plugin :render, escape: true
  plugin :static, ['/js', '/css']

  route do |r|
    # GET / request
    r.root do
      view :home
    end

    r.get "about" do
      view("about")
    end

    r.get "cookie-guide" do
      view("cookie-guide")
    end

    # All routes starting with /hotspots
    r.on 'hotspots' do

      # Get an array of hotspots from the backend
      resp = RestClient.get('http://hotsp-backend.eu-gb.mybluemix.net/api/hotspots')
      resp = JSON.parse(resp)
      #puts "Response:" + JSON.pretty_generate(resp)

      # Set a variable that is available for all routes in /hotspots
      @hotspots = []

      resp.each do |hotsp|
        # Use http://m.osmtools.de/ to find the latlon of a map point
        @hotspots.push( Hotspot.new(name: hotsp["name"], latitude: hotsp["latitude"], longitude: hotsp["longitude"], status: hotsp["status"]) )
      end

      # GET /hotspots
      r.on do
        # r.root do               # natch only '/hotspots/'
        r.get ["", true]   do      # match '/hotspots' AND '/hotspots/'
          view("hotspots/map")
        end

        r.get "list" do
          view("hotspots/list")
        end

        # GET /hotspots/new
        r.get 'new' do
          @hotspot = Hotspot.new
          view("hotspots/new")
        end

        #GET /hotspots/map-hotspots
        # GET /hotspots/map
        r.get 'map' do
          view("hotspots/map")
        end

        # POST /hotspots
        r.post do
          warn "***** #{r.params}"
          flash[:success] = "Thank you for updating this hotspot!"
          r.redirect
        end
      end # //
    end # hotspots
  end

#  def view_method
#    'foo'
#  end
end

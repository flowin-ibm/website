# The top level 'Configuration' file of the website
# required by Rack, so that 'bundle exec rackup' actualy
# actually loads the application after start of the server

require File.expand_path("../flowin", __FILE__)

run App.freeze.app

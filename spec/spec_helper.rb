ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'rack/test'
require 'shoulda-matchers'

def app
  CorvaTestApp
end

app.set :logging, false
app.set :run, false
app.set :raise_errors, true

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

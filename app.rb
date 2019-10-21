require "sinatra"
require 'sinatra/reloader' if development?

class CorvaTestApp < Sinatra::Base
  get "*" do
    halt status 400
  end

  post "*" do
    halt status 400
  end
end

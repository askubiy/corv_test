require "sinatra"

class CorvaTestApp < Sinatra::Base
  get "/" do
    "Hello world!"
  end
end

require "sinatra/base"

class App < Sinatra::Base
  get "/PING" do
    "PONG"
  end
end

run App.new

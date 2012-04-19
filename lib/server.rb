require "sinatra/base"

class Server < Sinatra::Base

  get "/" do
    "foo"
  end

end
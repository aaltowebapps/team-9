$LOAD_PATH << "./lib" # Add lib directory to load path

require "sinatra"

require "api"
require "server"

map "/api" do 
  run API
end  

map "/" do 
  run Server
end
require "json"
require "yaml"
require "savon"
require "sinatra"
require "active_support/core_ext"


get "/" do
  settings = YAML::load(File.open("settings.yml"))

  client = Savon::Client.new do
   wsdl.document = "http://stp.gofore.com/sujuvuus/ws/journeyTime?wsdl"
   http.auth.basic(settings["username"], settings["password"])
  end

  response = client.request(:journey_time)

  content_type :json
  response.to_json
end
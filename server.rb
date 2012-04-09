require "yaml"
require "savon"

settings = YAML::load(File.open("settings.yml"))

client = Savon::Client.new do
 wsdl.document = "http://stp.gofore.com/sujuvuus/ws/journeyTime?wsdl"
 http.auth.basic(settings["username"], settings["password"])
end

response = client.request(:journey_time) do
  soap.body = { :id => 1 }
end

puts response.body
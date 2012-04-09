require "rubygems" if RUBY_VERSION < "1.9"
require "json"
require "yaml"
require "savon"
require "sinatra/base"
require "active_support/core_ext"

class API < Sinatra::Base

  SETTINGS = YAML::load(File.open("settings.yml"))
  WS_URL = "http://stp.gofore.com/sujuvuus/ws/"

  types = %w(journeyTime trafficFluency dayData averageDayData lamData freeFlowSpeeds roadWeather roadStationStatuses cameraPresets)

  types.each do |type|

    type_underscored = type.underscore.to_sym

    get "/#{type_underscored}" do
      client = Savon::Client.new do
        wsdl.document = "#{WS_URL + type}?wsdl"
        http.auth.basic(SETTINGS["username"], SETTINGS["password"])
      end

      response = client.request(type_underscored)

      content_type :json
      response.to_json
    end

  end

end
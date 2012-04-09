require "rubygems" if RUBY_VERSION < "1.9"
require "json"
require "yaml"
require "savon"
require "sinatra/base"
require "active_support/core_ext"

class API < Sinatra::Base

  SETTINGS = YAML::load(File.open("settings.yml"))
  WS_URL = "http://stp.gofore.com/sujuvuus/ws/"

  types = %w(journey_time traffic_fluency day_data average_day_data lam_data free_flow_speeds road_weather road_station_statuses camera_presets)

  get "/" do
    types.join(" ")
  end

  types.each do |type|

    get "/#{type}" do
      client = Savon::Client.new do
        wsdl.document = "#{WS_URL + type.camelize(:lower)}?wsdl"
        http.auth.basic(SETTINGS["username"], SETTINGS["password"])
      end

      response = client.request(type)

      content_type :json
      response.to_json
    end

  end

end
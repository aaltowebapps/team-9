require "json"
require "yaml"
require "redis"
require "savon"
require "sinatra/base"
require "active_support/core_ext"

class API < Sinatra::Base

  SETTINGS = YAML::load(File.open("settings.yml"))
  WS_URL = "http://stp.gofore.com/sujuvuus/ws/"

  types = %w(journey_time traffic_fluency day_data average_day_data lam_data free_flow_speeds road_weather road_station_statuses camera_presets)
  redis = Redis.new

  before do
    content_type :json
  end

  get "/" do
    types.map{ |t| "http://#{request.host_with_port}/api/#{t}" }.to_json
  end

  types.each do |type|
    get "/" + type do
      unless (response = redis.get(type))
        response = savon_client.request(type).to_json
        redis.set(type, response)
      end
      response
    end
  end

  def savon_client
    Savon::Client.new do
      wsdl.document = "#{WS_URL + type.camelize(:lower)}?wsdl"
      http.auth.basic(SETTINGS["username"], SETTINGS["password"])
    end
  end

end
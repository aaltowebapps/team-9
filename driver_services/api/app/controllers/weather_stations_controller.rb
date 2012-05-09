class WeatherStationsController < ApplicationController
  def index
    @weather_stations = WeatherStation.all
    render :json => @weather_stations.to_json
  end
end

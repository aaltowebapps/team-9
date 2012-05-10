class WeatherStationsController < ApplicationController

  def index
    @weather_stations = WeatherStation.all
    render :json => @weather_stations.to_json
  end

  def show
    @weather_station = WeatherStation.find(params[:id])
    render :json => @weather_station
  end

end

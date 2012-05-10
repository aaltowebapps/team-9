class WeatherStationsController < ApplicationController

  def index
    @weather_station = WeatherStation.all
    render :json => @weather_station
  end

  def show
    @weather_station = WeatherStation.find(params[:id])
    render :json => @weather_station
  end

end

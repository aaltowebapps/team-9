class WeatherStationsController < ApplicationController

  def index
    if params[:road]
      @weather_stations = WeatherStation.find_all_by_road(params[:road])
    else
      @weather_stations = WeatherStation.page(params[:page])
    end
    render :json => @weather_stations.map {|c| WeatherStationArraySerializer.new(c) }.to_json
  end

  def show
    @weather_station = WeatherStation.find(params[:id])
    render :json => @weather_station
  end

end

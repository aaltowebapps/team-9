class WeatherStationsController < ApplicationController

  def index
    example = WeatherStation.new(params[:weather_station])
    @weather_stations = WeatherStation.find_all_by_example(example)
                                      .order_by([[:station_number, :asc]])
                                      .page(params[:page])

    render :json => @weather_stations.map {|c| WeatherStationArraySerializer.new(c) }.to_json
  end

  def show
    @weather_station = WeatherStation.find(params[:id])
    render :json => @weather_station
  end

end

class WeatherStationsController < ApplicationController

  def index
    example = WeatherStation.new(:road => params[:road], :location => [params[:latitude].to_f, params[:longitude].to_f])
    @weather_stations = WeatherStation.find_all_by_example(example)
                                      .excludes(location: [0, 0], observation_data: nil)
                                      .order_by([[:station_number, :asc]])
                                      .page(params[:page])

    render :json => @weather_stations.map {|c| WeatherStationArraySerializer.new(c) }.to_json
  end

  def show
    @weather_station = WeatherStation.find(params[:id])
    render :json => @weather_station
  end

end

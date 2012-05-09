require 'spec_helper'

describe WeatherStationsController do
  context "GET index" do
    it "assigns all weather_stations to @weather_stations" do
      weather_station = FactoryGirl.create(:weather_station)
      get :index
      assigns(:weather_stations).should eq([weather_station])
    end
  end
end

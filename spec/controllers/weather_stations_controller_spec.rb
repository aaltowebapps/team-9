require 'spec_helper'

describe WeatherStationsController do

  let!(:weather_station) { FactoryGirl.create(:weather_station) }

  describe "GET index" do
    before(:each) { get :index }
    it { should respond_with(:success) }
    it { should assign_to(:weather_stations).with([weather_station]) }
  end

  describe "GET show" do
    before(:each) { get :show, {:id => weather_station.to_param} }
    it { should respond_with(:success) }
    it { should assign_to(:weather_station).with(weather_station) }
  end

end

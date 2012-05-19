require 'spec_helper'

describe WeatherStation do

  describe ".find_all_by_example" do

    before { 5.times { FactoryGirl.create(:weather_station) } }

    context "without an example" do
      subject { WeatherStation.find_all_by_example(nil) }
      it "returns all weather stations" do 
        subject.size.should == 5
      end
    end

    context "with an example road" do
      let(:example) { WeatherStation.new(:road => 1) }
      subject { WeatherStation.find_all_by_example(example) }

      it "filters the stations by road" do
        subject.each{|r| r.road.should == example.road }
      end
    end

    context "with an example location" do
      let(:example) { WeatherStation.new(:road => 1) }
      subject { WeatherStation.find_all_by_example(example) }

      it "filters the stations by location" do
        
      end
    end

  end

end

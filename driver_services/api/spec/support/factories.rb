require "factory_girl"

FactoryGirl.define do
  factory :weather_station do 
    latitude 60.1234
    longitude 24.5432
    road 1
  end
end

FactoryGirl.define do
  factory :observation_data do
    temperature 13
    visibility 1000
  end
end
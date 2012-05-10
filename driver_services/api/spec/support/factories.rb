require "factory_girl"

FactoryGirl.define do
  factory :weather_station do 
    location "u4pruydqqvj"
    road 1
  end
end

FactoryGirl.define do
  factory :observation_data do
    temperature 13
    visibility 1000
  end
end
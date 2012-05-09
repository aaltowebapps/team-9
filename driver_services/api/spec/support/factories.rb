require "factory_girl"

FactoryGirl.define do
  factory :weather_station do 
    location "u4pruydqqvj"
    temperature 13
    visibility 2000
  end
end
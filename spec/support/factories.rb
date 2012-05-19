require "factory_girl"

FactoryGirl.define do
  factory :observation_data do
    temperature 13
    visibility 1000
  end

  factory :weather_station do 
    location { FactoryGirl.generate(:location) }
    road { FactoryGirl.generate(:road) }
    observation_data { FactoryGirl.build(:observation_data) }
  end

  sequence :road do |n|
    n%4
  end

  sequence :location do
    [10 + rand() * 50, 10 + rand() * 50]
  end

end


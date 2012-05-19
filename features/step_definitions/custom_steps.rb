Given /^(\d+) weather stations exist with location: \[([0-9.]+), ([0-9.]+)\]$/ do |count, latitude, longitude|
  create_model(:weather_station, :location => [latitude.to_f, longitude.to_f])
end
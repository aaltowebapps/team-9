require "open-uri"
require "spreadsheet"
require "savon"
namespace :load do

    desc "load weather stations from excel provided by digitraffic"
    task :weather_stations => :environment do

      EXCEL_URL = "http://www.infotripla.fi/digitraffic/docs/Meta_RWS_stations_ver20101130.xls"

      excel = nil
      open(EXCEL_URL) do |f|
        excel = Spreadsheet.open f
      end

      if excel 
        Spreadsheet.client_encoding = "UTF-8"
        sheet = excel.worksheet(0)

        sheet.each 12 do |row|
          ws = WeatherStation.find_or_initialize_by_id(row[0])
          ws.road = row[2].to_i
          ws.latitude = sprintf( "%0.04f", row[12] + row[13] / 60 + row[14] / (60 * 60) ) rescue nil
          ws.longitude = sprintf( "%0.04f", row[15] + row[16] / 60 + row[17] / (60 * 60) ) rescue nil
          ws.save
        end

      else
        puts "Could not open the excel file"
      end
      
    end

    desc "load observation data from digitraffic api"
    task :observation_data => :environment do 
      SETTINGS = YAML::load(IO.read(File.join(Rails.root, 'config', 'settings.yml')))

      client = Savon::Client.new do
        wsdl.document = "http://stp.gofore.com/sujuvuus/ws/roadWeather?wsdl"
        http.auth.basic(SETTINGS["username"], SETTINGS["password"])
      end

      observations = client.request("road_weather").to_hash[:road_weather_response][:roadweatherdata][:roadweather]

      observations.each do |observation|
        od = ObservationData.find_or_initialize_by_weather_station_id(observation[:stationid])
        od.temperature = observation[:airtemperature1]
        od.visibility = observation[:visibility]
        od.save
      end

    end

end
require "open-uri"
require "spreadsheet"
require "savon"
namespace :load do

    desc "load weather stations from excel provided by digitraffic"
    task :weather_stations => :environment do

      EXCEL_URL = "http://www.infotripla.fi/digitraffic/docs/Meta_RWS_stations_ver20101130.xls"

      puts "Loading url"

      excel = nil
      open(EXCEL_URL) do |f|
        excel = Spreadsheet.open f
      end

      if excel 
        puts "Loading excel"

        Spreadsheet.client_encoding = "UTF-8"
        sheet = excel.worksheet(0)

        sheet.each 12 do |row|
          ws = WeatherStation.find_or_initialize_by(:station_number => row[0].to_i)
          ws.station_number = row[0].to_i
          ws.road = row[2].to_i
          latitude = sprintf( "%0.04f", row[12] + row[13] / 60 + row[14] / (60 * 60) ).to_f rescue 0
          longitude = sprintf( "%0.04f", row[15] + row[16] / 60 + row[17] / (60 * 60) ).to_f rescue 0
          ws.location = [latitude, longitude]
          ws.save
        end

      else
        puts "Could not open the excel file"
      end
      
    end

    desc "load observation data from digitraffic api"
    task :observation_data => :environment do 
      if ENV["DIGITRAFFIC_USERNAME"] && ENV["DIGITRAFFIC_PASSWORD"]
        SETTINGS = Hash.new
        SETTINGS["username"] = ENV["DIGITRAFFIC_USERNAME"]
        SETTINGS["password"] = ENV["DIGITRAFFIC_PASSWORD"]
      else
        SETTINGS = YAML::load(IO.read(File.join(Rails.root, 'config', 'settings.yml')))
      end

      client = Savon::Client.new do
        wsdl.document = "http://stp.gofore.com/sujuvuus/ws/roadWeather?wsdl"
        http.auth.basic(SETTINGS["username"], SETTINGS["password"])
      end

      observations = client.request("road_weather").to_hash[:road_weather_response][:roadweatherdata][:roadweather]

      observations.each do |observation|
        begin 
          ws = WeatherStation.first(:conditions => { :station_number => observation[:stationid] } )
          ws.observation_data = ObservationData.new
          ws.observation_data.temperature = observation[:airtemperature1]
          ws.observation_data.visibility = observation[:visibilitymeters]
          ws.observation_data.precipitation = observation[:precipitation]
          ws.save
        rescue
          puts "Warning: no weather station found with station number #{observation[:stationid]}"
        end
      end

    end

end
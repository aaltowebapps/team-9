require "open-uri"
require "spreadsheet"
namespace :import do

    desc "load weather stations from excel"
    task :weather_stations => :environment do

      excel_url = "http://www.infotripla.fi/digitraffic/docs/Meta_RWS_stations_ver20101130.xls"

      excel = nil
      open(excel_url) do |f|
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

end
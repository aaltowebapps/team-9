class WeatherStation
  include Mongoid::Document
 
  field :station_number, :type => Integer
  field :road, :type => Integer
  field :location, :type => Array

  index([[ :location, Mongo::GEO2D ]])

  embeds_one :observation_data, :class_name => "ObservationData"

  class << self

    def find_all_by_example(example)
      example ||= OpenStruct.new(:road => nil, :coordinates => nil)
      by_road(example.road).
      by_location(example.location)
    end

    def by_road(road)
      by_attribute_or_scoped(road) { where(:road => road) }
    end

    def by_location(location)
      by_attribute_or_scoped(location) { near(:location => location) }
    end

    def by_attribute_or_scoped(attribute)
      attribute ? yield : scoped
    end

  end

end

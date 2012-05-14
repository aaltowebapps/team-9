class ObservationData
  include Mongoid::Document
  field :temperature, :type => Integer
  field :visibility, :type => Integer

  embedded_in :weather_station
end

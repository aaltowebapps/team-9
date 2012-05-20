class ObservationDataSerializer < ActiveModel::Serializer
  attributes :temperature, :visibility, :precipitation
end

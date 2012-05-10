class ObservationDataSerializer < ActiveModel::Serializer
  attributes :temperature, :visibility, :updated_at
end

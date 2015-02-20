class StoreSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :city, :street, :postalcode, :longitude, :latitude
end

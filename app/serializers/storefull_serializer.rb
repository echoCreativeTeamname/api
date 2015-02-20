class StorefullSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :city, :street, :postalcode, :longitude, :latitude
  has_many :openinghours
  has_one :chain
end

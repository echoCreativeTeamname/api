class StoreSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :city, :street, :postalcode, :longitude, :latitude, :chain

  def chain
    object.chain.uuid
  end

end

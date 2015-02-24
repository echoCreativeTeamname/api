class StoreSerializer < ActiveModel::Serializer
  attributes :uuid, :chain, :name, :city, :street, :postalcode, :latitude, :longitude

  def chain
    object.chain.uuid
  end

end

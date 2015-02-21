class StoreSerializer < ActiveModel::Serializer
  attributes :uuid, :chain, :name, :city, :street, :postalcode, :longitude, :latitude

  def chain
    object.chain.uuid
  end

end

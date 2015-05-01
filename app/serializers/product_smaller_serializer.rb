class ProductSmallerSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount, :lastupdated, :storechain

  def storechain
    object.storechain.uuid
  end
end

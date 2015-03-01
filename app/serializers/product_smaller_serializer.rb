class ProductSmallerSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :price, :amount, :lastupdated, :storechain

  def storechain
    object.storechain.uuid
  end
end

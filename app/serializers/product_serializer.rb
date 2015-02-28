class ProductSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :price, :amount, :lastupdated
  has_one :storechain
end

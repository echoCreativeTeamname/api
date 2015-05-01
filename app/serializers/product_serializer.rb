class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount, :lastupdated
  has_one :storechain
end

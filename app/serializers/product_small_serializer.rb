class ProductSmallSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :amount, :lastupdated
end

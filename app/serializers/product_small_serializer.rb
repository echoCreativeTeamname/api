class ProductSmallSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :price, :amount, :lastupdated
end

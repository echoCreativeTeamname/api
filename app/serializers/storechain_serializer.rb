class StorechainSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :healthclass, :priceclass, :lastupdated
end

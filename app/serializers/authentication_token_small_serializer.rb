class AuthenticationTokenSmallSerializer < ActiveModel::Serializer
  attributes :token, :valid_till
end

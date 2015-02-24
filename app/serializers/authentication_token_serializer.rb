class AuthenticationTokenSerializer < ActiveModel::Serializer
  attributes :token, :valid_till
  has_one :user
end

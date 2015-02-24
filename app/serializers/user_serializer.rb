class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :email, :city, :street, :postalcode, :latitude, :longitude, :settings

  def settings
    object.get_all_settings
  end

end

class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :email, :city, :street, :postalcode, :longitude, :latitude, :settings

  def settings
    object.get_all_settings
  end

end

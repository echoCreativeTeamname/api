=begin
User
 - id (auto)
 - UUID (auto)
 - email
 - password (TODO: bcrypt?)
 - city
 - postalcode
 - street
 - latitude
 - longitude
=end

class User < ActiveRecord::Base

  DEFAULT_SETTINGS = {
    food_expenses_monthly: 152, # Amount in euros to be spend on food each month by user
    healthiness_level: 1, # Healthiness of the to be consumed food (0: fast food, 1: average, 2: extremely healthy)
    vegetarian: false, # Is user vegetarian?
    vegan: false # Is user vegan?
  }

  validates :email, :password,  presence: true
  validates_format_of :email, :with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,6}/
  has_many :settings, class_name: "UserSetting", dependent: :destroy
  has_many :authenticationtokens, class_name: "AuthenticationToken", dependent: :destroy

  def get_setting(setting_name)
    if(DEFAULT_SETTINGS.key?(setting_name.to_sym))
      return self.settings.where(key: setting_name.to_s).first.get_value || DEFAULT_SETTINGS[setting_name.to_sym]
    else
      return false
    end
  end

  def set_setting(setting_name, value)
    if(DEFAULT_SETTINGS.key?(setting_name.to_sym))
      self.settings.where(key: setting_name.to_s).destroy_all
      return self.settings.new(key: setting_name.to_s, value: value).save ? true : false
    else
      return false
    end
  end

  def get_all_settings()
    set_settings = {}
    self.settings.all.each do |setting|
      set_settings[setting.key.to_sym] = setting.get_value
    end
    return DEFAULT_SETTINGS.merge(set_settings)
  end

  #UUID
  before_create :check_uuid
  def check_uuid
    unless(self.uuid)
      self.uuid = SecureRandom.uuid
    end
  end

end

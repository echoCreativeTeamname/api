class UserSetting < ActiveRecord::Base
  belongs_to :user
  validates :key, :value,  presence: true

  def get_value
    return self.value.numeric? ? self.value.to_f : self.value
  end
end

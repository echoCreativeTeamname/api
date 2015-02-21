=begin
User
 - id (auto)
 - UUID (auto)

=end

class User < ActiveRecord::Base

  validates :email, :password,  presence: true
  validates_format_of :email, :with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,6}/
  has_many :settings, class_name: "UserSetting"

end

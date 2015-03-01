=begin
Recipe
 - id (auto)
 - UUID (auto)
 - url
 - name
 - type
 - portions
 - cookingtime
 - contents
 - summary
 - imageurl
=end

class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  #UUID
  before_create :check_uuid
  def check_uuid
    unless(self.uuid)
      self.uuid = SecureRandom.uuid
    end
  end
end

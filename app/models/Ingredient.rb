=begin
Ingredient
 - id (auto)
 - UUID (auto)
 - name
 - healthclass
 -
=end

class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :products
  has_many :recipes, through: :recipe_ingredients

  #UUID
  before_create :check_uuid
  def check_uuid
    unless(self.uuid)
      self.uuid = SecureRandom.uuid
    end
  end
end

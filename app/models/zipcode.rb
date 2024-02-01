class Zipcode < ApplicationRecord
  # has_many :event

  has_one :town
  has_one :city, through: :town
  has_one :prefecture, through: :city

  def self.ransackable_attributes(_auth_object = nil)
    ['id']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[city prefecture town]
  end
end

class Prefecture < ApplicationRecord
  has_many :cities
  has_many :towns, through: :cities

  def self.ransackable_attributes(_auth_object = nil)
    %w[id kana name]
  end
end

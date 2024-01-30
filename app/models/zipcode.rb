class Zipcode < ApplicationRecord
  # has_many :event

  has_one :town
  has_one :city, through: :town
  has_one :prefecture, through: :city
end

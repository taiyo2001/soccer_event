class City < ApplicationRecord
  belongs_to :prefecture
  has_many :towns
  has_many :zipcodes, through: :towns
end

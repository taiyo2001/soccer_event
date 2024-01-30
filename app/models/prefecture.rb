class Prefecture < ApplicationRecord
  has_many :cities
  has_many :towns, through: :cities
end

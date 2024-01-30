class Town < ApplicationRecord
  belongs_to :city
  belongs_to :zipcode
end

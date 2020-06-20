class City < ApplicationRecord
  belongs_to :governorate
  has_many :cases
  has_many :charities
end

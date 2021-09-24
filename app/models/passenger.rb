class Passenger < ApplicationRecord
  has_many :excursions
  has_many :flights, through: :excursions
end

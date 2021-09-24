class Flight < ApplicationRecord
  belongs_to :airline
  has_many   :excursions
  has_many   :passengers, through: :excursions
end

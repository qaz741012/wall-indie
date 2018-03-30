class Place < ApplicationRecord
  has_many :cessions
  has_many :events, through: :cessions

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end

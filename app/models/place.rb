class Place < ApplicationRecord
  has_many :cessions

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end

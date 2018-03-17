class Favorit < ApplicationRecord
  belongs_to :artist, counter_cache: true
  belongs_to :user
end

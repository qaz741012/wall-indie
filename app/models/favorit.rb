class Favorit < ApplicationRecord

  # user只能對每個artist favorite一次
  validates :artist_id, uniqueness: {scope: :user_id}

  belongs_to :artist, counter_cache: true
  belongs_to :user
end

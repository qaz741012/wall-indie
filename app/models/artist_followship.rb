class ArtistFollowship < ApplicationRecord

  # user只能對每個artist follow一次
  validates :artist_id, uniqueness: {scope: :user_id}

  belongs_to :artist, counter_cache: true
  belongs_to :user
end

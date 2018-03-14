class Artist < ApplicationRecord
  has_many :musics
  has_many :shows

  #user followed
  has_many :artist_followships
  has_many :artist_followed, through: :artist_followships, source: :user

  #user favorit
  has_many :favorits
  has_many :favorited, through: :favorits, source: :user
end

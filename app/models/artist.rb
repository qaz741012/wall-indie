class Artist < ApplicationRecord
  has_many :musics

  #artist_event relationship
  has_many :shows
  has_many :events, through: :shows

  #user followed
  has_many :artist_followships
  has_many :artist_followed, through: :artist_followships, source: :user

  #user favorit
  has_many :favorits
  has_many :favorited, through: :favorits, source: :user
end

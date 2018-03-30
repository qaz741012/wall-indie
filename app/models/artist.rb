class Artist < ApplicationRecord
  #掛載 carrierwave
  mount_uploader :photo, PhotoUploader
  has_many :musics

  #artist_event relationship
  has_many :shows, dependent: :destroy
  has_many :events, through: :shows

  #user followed
  has_many :artist_followships, dependent: :destroy
  has_many :artist_followed, through: :artist_followships, source: :user

  #user favorit
  has_many :favorits, dependent: :destroy
  has_many :favorited, through: :favorits, source: :user


end

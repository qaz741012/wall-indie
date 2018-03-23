class Event < ApplicationRecord
  #carrierwave掛載
  mount_uploader :photo, PhotoUploader

  has_many :shows, dependent: :destroy
  has_many :artists, through: :shows

  #user follow event
  has_many :event_followships, dependent: :destroy
  has_many :event_followed, through: :event_followships, source: :user

  has_many :cessions, dependent: :destroy
end

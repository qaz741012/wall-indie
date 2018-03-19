class Event < ApplicationRecord
  #carrierwave掛載
  mount_uploader :photo, PhotoUploader

  has_many :shows

  #user follow event
  has_many :event_followships
  has_many :event_followed, through: :event_followships, source: :user
  
  has_many :cessoions
end

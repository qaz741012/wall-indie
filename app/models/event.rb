# Event
class Event < ApplicationRecord
  scope :feature, -> { where(feature: true) }
  # carrierwave mount
  mount_uploader :photo, PhotoUploader

  has_many :shows, dependent: :destroy
  has_many :artists, through: :shows

  # user follow event
  has_many :event_followships, dependent: :destroy
  has_many :event_followed, through: :event_followships, source: :user

  has_many :cessions, dependent: :destroy
  has_many :places, through: :cessions

  def gmaps4rails_infowindow
    " #{name} "
  end
end

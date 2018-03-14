class Event < ApplicationRecord
  has_many :shows

  #user follow event
  has_many :event_followships
  has_many :event_followed, through: :event_followships, source: :user
  
  has_many :cessoions
end

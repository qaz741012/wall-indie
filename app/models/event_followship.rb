class EventFollowship < ApplicationRecord

  # user只能對每個artist follow一次
  validates :event_id, uniqueness: {scope: :user_id}

  belongs_to :user
  belongs_to :event
end

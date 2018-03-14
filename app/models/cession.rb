class Cession < ApplicationRecord
  belongs_to :place
  belongs_to :event
end

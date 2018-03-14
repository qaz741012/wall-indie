class CreateEventFollowships < ActiveRecord::Migration[5.1]
  def change
    create_table :event_followships do |t|

      t.timestamps
    end
  end
end

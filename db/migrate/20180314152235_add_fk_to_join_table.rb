class AddFkToJoinTable < ActiveRecord::Migration[5.1]
  def change
    add_column :cessions, :event_id, :integer
    add_column :cessions, :place_id, :integer
    add_column :shows, :artist_id, :integer
    add_column :shows, :event_id, :integer
    add_column :event_followships, :user_id, :integer
    add_column :event_followships, :event_id, :integer
    add_column :artist_followships, :user_id, :integer
    add_column :artist_followships, :artist_id, :integer
    add_column :friendships, :user_id, :integer
    add_column :friendships, :friend_id, :integer
    add_column :favorits, :user_id, :integer
    add_column :favorits, :artist_id, :integer
    add_column :musics, :artist_id, :integer
  end
end

class AddSpotifyOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :spotify_uid, :string
    add_column :users, :spotify_token, :string
  end
end

class AddArtistFollowshipsCountAndFavoritsCountToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :artist_followships_count, :integer, default: 0
    add_column :artists, :favorits_count, :integer, default: 0
  end
end

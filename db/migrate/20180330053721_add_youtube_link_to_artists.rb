class AddYoutubeLinkToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :youtube_link, :string
  end
end

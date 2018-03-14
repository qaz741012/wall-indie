class CreateArtistFollowships < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_followships do |t|

      t.timestamps
    end
  end
end

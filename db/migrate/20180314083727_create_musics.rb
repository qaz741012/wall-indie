class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.string :name
      t.text :intro
      t.string :link

      t.timestamps
    end
  end
end

class CreateShows < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.date :time

      t.timestamps
    end
  end
end

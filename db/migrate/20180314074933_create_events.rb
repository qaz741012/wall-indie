class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :photo
      t.text :intro
      t.date :date
      t.string :time
      t.string :ticket_link
      t.string :organizer

      t.timestamps
    end
  end
end

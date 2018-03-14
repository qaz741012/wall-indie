class CreateCessions < ActiveRecord::Migration[5.1]
  def change
    create_table :cessions do |t|

      t.timestamps
    end
  end
end

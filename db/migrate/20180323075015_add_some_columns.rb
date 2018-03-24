class AddSomeColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :week, :string
    add_column :events, :price, :string
  end
end

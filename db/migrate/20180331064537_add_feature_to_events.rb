class AddFeatureToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :feature, :boolean
  end
end

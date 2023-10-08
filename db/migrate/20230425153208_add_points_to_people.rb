class AddPointsToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :points, :decimal
  end
end

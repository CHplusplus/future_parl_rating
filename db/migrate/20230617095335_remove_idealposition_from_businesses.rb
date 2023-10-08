class RemoveIdealpositionFromBusinesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :businesses, :idealposition, :integer
  end
end

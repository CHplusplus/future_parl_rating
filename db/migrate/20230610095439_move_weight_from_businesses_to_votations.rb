class MoveWeightFromBusinessesToVotations < ActiveRecord::Migration[7.0]
  def change
    remove_column :businesses, :weight, :float
    add_column :votations, :weight, :float
  end
end
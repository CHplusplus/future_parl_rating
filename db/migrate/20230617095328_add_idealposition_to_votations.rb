class AddIdealpositionToVotations < ActiveRecord::Migration[7.0]
  def change
    add_column :votations, :idealposition, :integer
  end
end

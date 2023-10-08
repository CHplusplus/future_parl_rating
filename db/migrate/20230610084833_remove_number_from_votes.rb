class RemoveNumberFromVotes < ActiveRecord::Migration[7.0]
  def change
    remove_column :votes, :number, :integer
  end
end

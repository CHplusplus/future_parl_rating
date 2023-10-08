class AddNumberToVotes < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :number, :integer
  end
end

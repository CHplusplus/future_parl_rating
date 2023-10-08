class AddPositionToVotes < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :position, :integer
  end
end

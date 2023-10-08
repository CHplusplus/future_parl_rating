class AddConstraintsToPositionInVotes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :votes, :position, false
    add_check_constraint :votes, "position BETWEEN 0 AND 5", name: "check_position_range"
  end
end
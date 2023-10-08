class AddReputationToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :reputation, :decimal
  end
end

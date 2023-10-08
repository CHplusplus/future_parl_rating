class AddReferenceToVotations < ActiveRecord::Migration[7.0]
  def change
    add_column :votations, :reference, :string
  end
end

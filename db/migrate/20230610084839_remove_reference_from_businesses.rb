class RemoveReferenceFromBusinesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :businesses, :reference, :string
  end
end

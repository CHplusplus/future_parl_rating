class ChangeTypenameInBusinesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :businesses, :typename
    add_column :businesses, :business_type, :integer, null: false
  end
end

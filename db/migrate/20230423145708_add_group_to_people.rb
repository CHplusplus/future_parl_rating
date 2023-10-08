class AddGroupToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :group, :string
  end
end

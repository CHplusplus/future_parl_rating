class ModifyBusinesses < ActiveRecord::Migration[7.0]
  def change
    # Add new title columns
    add_column :businesses, :title_de, :string
    add_column :businesses, :title_fr, :string
    add_column :businesses, :title_it, :string

    # Remove the old title column
    remove_column :businesses, :title, :string

    # Add new link columns
    add_column :businesses, :link_de, :string
    add_column :businesses, :link_fr, :string
    add_column :businesses, :link_it, :string
  end
end

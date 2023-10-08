class AddSlugToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :slug, :string
  end
end

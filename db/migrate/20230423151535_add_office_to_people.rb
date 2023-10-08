class AddOfficeToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :office, :string
  end
end

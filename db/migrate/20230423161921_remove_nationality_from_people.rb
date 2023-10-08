class RemoveNationalityFromPeople < ActiveRecord::Migration[7.0]
  def change
    remove_column :people, :nationality, :string
  end
end

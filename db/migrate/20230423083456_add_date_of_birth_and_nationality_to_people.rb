class AddDateOfBirthAndNationalityToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :date_of_birth, :date
    add_column :people, :nationality, :string
  end
end

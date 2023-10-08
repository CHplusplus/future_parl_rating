class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :reference
      t.float :weight
      t.string :typename
      t.string :shortnumber
      t.integer :idealposition
      t.string :title

      t.timestamps
    end
  end
end

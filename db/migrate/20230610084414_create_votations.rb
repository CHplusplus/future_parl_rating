class CreateVotations < ActiveRecord::Migration[7.0]
  def change
    create_table :votations do |t|
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end

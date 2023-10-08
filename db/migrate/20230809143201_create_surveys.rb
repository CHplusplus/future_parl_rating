class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.string :title_de
      t.string :title_fr
      t.string :title_it

      t.timestamps
    end
  end
end

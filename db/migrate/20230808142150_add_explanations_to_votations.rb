class AddExplanationsToVotations < ActiveRecord::Migration[7.0]
  def change
    add_column :votations, :explanation_de, :string
    add_column :votations, :explanation_fr, :string
  end
end

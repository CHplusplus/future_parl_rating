class ChangeBusinessToVotationInVotes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :votes, :business, index: true, foreign_key: true
    add_reference :votes, :votation, null: false, foreign_key: true
  end
end

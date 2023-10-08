class AddQuestionIdToResponses < ActiveRecord::Migration[7.0]
  def change
    add_reference :responses, :question, null: false, foreign_key: true
  end

end

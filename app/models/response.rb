class Response < ApplicationRecord
  belongs_to :question
  belongs_to :person
  belongs_to :survey 
  
  validates :person_id, uniqueness: { scope: :question_id, message: "can only have one response per question" }

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "person_id", "question_id", "survey_id", "updated_at"]
  end
end

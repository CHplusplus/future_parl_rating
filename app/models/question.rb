class Question < ApplicationRecord
  belongs_to :survey
  has_many :responses

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "survey_id", "title_de", "title_fr", "title_it", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["responses", "survey"]
  end
  
end

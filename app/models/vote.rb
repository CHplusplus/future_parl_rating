class Vote < ApplicationRecord
  belongs_to :person
  belongs_to :votation
  has_one :business, through: :votation

  validates :person, uniqueness: { scope: :votation, message: "can only vote once per votation" }
  validates :position, presence: true, inclusion: { in: 0..5, message: "must be between 0 and 5" }

  after_update :update_person_points
  after_destroy :update_person_points

  private

  def update_person_points
    person.calculate_points!
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "person_id", "position", "updated_at", "votation_id"]
  end
  
end
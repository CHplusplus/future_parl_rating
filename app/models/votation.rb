class Votation < ApplicationRecord
  belongs_to :business
  has_many :votes
  has_many :people, through: :votes
end

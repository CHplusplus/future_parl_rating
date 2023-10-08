class Business < ApplicationRecord
    
    NUMBER_OF_BUSINESS_TYPES = 4
    enum business_type: Hash[(1..NUMBER_OF_BUSINESS_TYPES).map { |i| ["business_type#{i}".to_sym, i] }]

    has_many :votations
    has_many :votes, through: :votations
    has_many :people, through: :votations

    validates :shortnumber, uniqueness: true


  end
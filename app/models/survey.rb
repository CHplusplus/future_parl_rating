class Survey < ApplicationRecord
    has_many :questions
    has_many :responses

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "title_de", "title_fr", "title_it", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["questions", "responses"]
    end
    
end

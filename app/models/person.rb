class Person < ApplicationRecord
    has_one_attached :image, dependent: :purge
    before_save :generate_slug
    has_many :votes
    has_many :votations, through: :votes
    has_many :businesses, through: :votations
    has_many :responses
    has_many :questions, through: :responses      

    def full_name
        "#{first_name} #{last_name}"
    end

    def to_param
        slug
    end

    def self.ransackable_attributes(auth_object = nil)
        ["canton", "created_at", "date_of_birth", "first_name", "group", "id", "last_name", "office", "party", "points", "slug", "reputation", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["businesses", "image_attachment", "image_blob", "questions", "responses", "votations", "votes"]
      end

      def calculate_points!
        #SURVEYS
        survey = Survey.where(title_de: "2023").first
        return unless survey  # return if survey is nil
      
        total_survey_points = 0
        # Mapping between response and its corresponding points.
        response_points = {
          "Ja" => 4,
          "Eher Ja" => 3,
          "Keine Antwort" => 2,
          "Eher Nein" => 1,
          "Nein" => 0
        }
      
        total_questions_in_survey = survey.questions.count
        return if total_questions_in_survey.zero?  # return if there are no questions in the survey
        
        total_possible_survey_points = response_points["Ja"] * total_questions_in_survey
        survey.questions.each do |question|
          response = self.responses.find_by(question: question)
          content = response ? response.content : "Keine Antwort"
          total_survey_points += response_points[content]
        end
        survey_percentage_achieved = (total_survey_points / total_possible_survey_points.to_f) * 100
        
        # FINAL POINTS
        self.points = survey_percentage_achieved
        
        # REPUTATION BOOST
        self.points += (self.reputation.to_i * 5)
        
        if self.points > 100
          self.points = 100
        end
      
        save
      end
      

    private

    def generate_slug
        self.slug = "#{first_name.parameterize}-#{last_name.parameterize}-#{canton}"
    end

end

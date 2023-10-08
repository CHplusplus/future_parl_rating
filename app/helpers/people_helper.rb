module PeopleHelper

    def rating_class_and_percentage(points)
        max = 100
        points = points.to_f # converts nil to 0.0
        percentage = (points / max) * 100
        rating_class =
          if percentage < 33.333
            'negative'
          elsif percentage < 66.666
            'neutral'
          else
            'positive'
          end
    
        [rating_class, percentage]
    end

end

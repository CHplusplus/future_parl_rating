namespace :person do
    desc "Update points for all people"
    task update_points: :environment do
      Person.find_each do |person|
        person.calculate_points!
      end
    end
  end
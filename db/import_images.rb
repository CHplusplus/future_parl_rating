require 'csv'

def process_csv(file_name)
  csv_text = File.read(Rails.root.join('db', file_name), encoding: 'UTF-8')
  csv = CSV.parse(csv_text, headers: true)

  csv.each do |row|
    ActiveRecord::Base.transaction do
      first_name = row['first_name'].strip
      last_name = row['last_name'].strip

      # Find the person by first_name and last_name
      person = Person.find_by(first_name: first_name, last_name: last_name)
      
      if person.present?
        puts "Person #{first_name}, Last Name: #{last_name} found"
        # Construct the image file path
        image_path = "db/images/#{row['id']}.jpg"

        # Check if the image file exists
        if File.exist?(image_path)
          # Attach the image to the person
          puts "File exists, trying to open #{image_path}, filename #{row['id']}.jpg"
          person.image.attach(io: File.open(image_path), filename: "#{row['id']}.jpg")
        else
          puts "Image not found for ID: #{row['id']}"
        end
      else
        puts "Person not found for First Name: #{first_name}, Last Name: #{last_name}"
      end
      sleep 0.1
    end
  end
end

['new_people.csv'].each do |file_name|
  process_csv(file_name)
end

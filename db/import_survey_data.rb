require 'csv'

def find_person_info(full_name)
  ['db/ch_nr_par.csv', 'db/ch_sr_par.csv'].each do |file|
    person_info = CSV.read(file, headers: true).find { |info| info["Name"] == full_name }
    return person_info if person_info
  end
  nil
end

# Importing the survey
survey_titles = { title_de: "2023", title_fr: "2023", title_it: "2023" }
survey = Survey.find_or_create_by!(survey_titles)

# Importing questions and creating a mapping for quick look-up
question_map = {}
CSV.foreach('db/survey_questions.csv', headers: true) do |row|
  question_attrs = {
    title_de: row["DE"],
    title_fr: row["FR"],
    title_it: row["IT"],
    survey: survey
  }
  question = Question.find_or_create_by!(question_attrs)
  question_map[row["Q"]] = question
end

# Importing responses
CSV.foreach('db/survey_responses.csv', headers: true) do |row|
  # Finding the person by name from either ch_nr_par.csv or ch_sr_par.csv
  full_name = row["Name"].strip
  person_info = find_person_info(full_name)
  
  if person_info
    person = Person.find_by(first_name: person_info["first_name"].strip, last_name: person_info["last_name"].strip)
    if person
      row.headers[1..-1].each do |header|
        # Using the header (like Q1, Q2, etc.) to get the corresponding question
        question = question_map[header]
        if question
          sanitized_content = row[header].titleize  
          response = Response.new(content: sanitized_content, question: question, person: person, survey: survey)
          unless response.save
            puts "Failed to save response for #{full_name} - Question: #{question.title_de}"
            puts response.errors.full_messages.join(", ")
          end
        else
          puts "Question with title #{header} not found."
        end
      end
    else
      puts "Person with name #{full_name} not found."
    end
  else
    puts "Info for person with name #{full_name} not found."
  end
end

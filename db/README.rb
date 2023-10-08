To import everything from scratch, perform the following steps:

1. Import the survey and questions by running the following in the console:

```
survey_json = File.read("db/survey.json")
survey_hash = JSON.parse(survey_json) 
Survey.create!(survey_hash.except("id", "created_at", "updated_at"))
questions_json = File.read("db/questions.json")
questions_array = JSON.parse(questions_json)
questions_array.each do |q_hash|
  Question.create!(q_hash.except("id", "created_at", "updated_at", "survey_id").merge(survey_id: 1))
end
```


2. Create all people and their responses by running
rails runner db/import_new_people.rb 

This step needs the file new_people.csv

3. To import image, run
rails runner db/import_images.rb

This needs the directory db/images to be present and populated with the images

4. To (re-)calculate the points for all people, run
bundle exec rake person:update_points

7. In case of asset changes, run
RAILS_ENV=production bundle exec rake assets:precompile locally, then commit to git and push to production.
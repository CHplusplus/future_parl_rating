json.extract! person, :id, :first_name, :last_name, :party, :canton, :created_at, :updated_at
json.url person_url(person, format: :json)

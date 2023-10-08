ActiveAdmin.register Response do
    permit_params :person_id, :question_id, :content, :survey_id 

    form do |f|
        f.inputs "Response Details" do
          f.input :person_id, as: :select, collection: Person.all.sort_by { |p| [p.last_name, p.first_name] }.map { |p| ["#{p.last_name}, #{p.first_name}", p.id] }
          f.input :survey_id, as: :select, collection: Survey.all.map { |s| [s.title_de, s.id] }
          f.input :question_id, as: :select, collection: Question.all.map { |q| ["Q#{q.id}: #{q.title_de[0..99]}", q.id] }
          f.input :content, as: :select, collection: ["Ja", "Eher Ja", "Keine Antwort", "Eher Nein", "Nein"], include_blank: "Select Response"
        end
        f.actions
      end
end

ActiveAdmin.register Person do
  permit_params :first_name, :last_name, :party, :canton, :date_of_birth, :group, :office, :reputation

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :party
    column :canton
    column :group
    column :office
    column :reputation
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :party
      row :canton
      row :group
      row :office
      row :reputation  # include reputation here
      # row :date_of_birth is not here, so it won't be displayed
    end
    Survey.all.each do |survey|
      panel "Survey: #{survey.title_de}" do
        questions = Question.joins(:responses).where(responses: { person_id: person.id }, survey_id: survey.id).distinct
        responses = Response.joins(:question).where(person_id: person.id, questions: { survey_id: survey.id })

        if questions.any?
          table_for questions do
            column "Question" do |question|
              question.title_de  # replace with appropriate language title
            end

            column "Response" do |question|
              response = responses.find { |r| r.question_id == question.id }
              response ? response.content : "No Response"
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :party
      f.input :canton
      f.input :date_of_birth 
      f.input :group
      f.input :office
      f.input :reputation
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  config.filters = [:first_name, :last_name, :party, :canton, :date_of_birth, :group, :office, :reputation]
end

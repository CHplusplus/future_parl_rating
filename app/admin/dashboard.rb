require 'zip'

# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Add export data link here
    div do
      link_to "Export Data", admin_dashboard_export_data_path
    end

    # The original welcome message
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end # content


  page_action :export_data, method: :get do
    # Generate CSV files
    csv_files = []
    [
      ["people", Person, ["id", "first_name", "last_name", "party", "canton", "date_of_birth", "group", "office", "points", "reputation"]],
      ["questions", Question, ["id", "title_de", "title_fr", "survey_id"]],
      ["responses", Response, ["id", "content", "survey_id", "person_id", "question_id"]],
      ["surveys", Survey, ["id", "title_de", "title_fr"]]
    ].each do |table_info|
      table_name, model, columns = table_info
      csv_file_path = Rails.root.join('tmp', "#{table_name}.csv")
      csv_files << csv_file_path

      CSV.open(csv_file_path, "wb") do |csv|
        csv << columns
        model.all.each do |record|
          csv << columns.map { |col| record.send(col) }
        end
      end
    end

    # Zip the CSV files
    zip_file_path = Rails.root.join('public', 'data_export.zip')
    File.delete(zip_file_path) if File.exist?(zip_file_path)
    Zip::File.open(zip_file_path, Zip::File::CREATE) do |zipfile|
      csv_files.each do |file|
        zipfile.add(File.basename(file), file)
      end
    end

    # Clean up individual CSV files
    csv_files.each { |file| File.delete(file) }
    redirect_to admin_dashboard_path, notice: "Data successfully exported."

  end

end

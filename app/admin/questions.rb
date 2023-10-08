ActiveAdmin.register Question do
    permit_params :content_de, :content_en, :content_fr, :survey_id # Add more attributes here
end
# Define the mapping of party names to their abbreviations
PARTY_ABBR = {
  "Schweizerische Volkspartei" => "SVP",
  "Sozialdemokratische Partei der Schweiz" => "SP",
  "FDP.Die Liberalen" => "FDP",
  "Die Mitte" => "CVP",
  "GRÜNE Schweiz" => "GPS",
  "Grüne (Basels starke Alternative)" => "GPS",
  "Alternative-die Grünen Kanton Zug" => "GPS",
  "Grünliberale Partei" => "GLP",
  "Bürgerlich-Demokratische Partei" => "BDP",
  "Evangelische Volkspartei der Schweiz" => "EVP",
  "Eidgenössisch-Demokratische Union" => "EDU",
  "Partei der Arbeit der Schweiz" => "PdA",
  "Schweizer Demokraten" => "SD",
  "Mouvement Citoyens Romands" => "MCR",
  "Lega dei Ticinesi" => "LEGA",
  "Ensemble à Gauche" => "EAG",
  "Die Junge Mitte" => "JCVP",
  "Junge Grünliberale" => "JGLP",
  "Junge Grüne" => "JGPS",
  "Jungfreisinnige" => "JFDP",
  "JUSO" => "JSP",
  "Junge SVP" => "JSVP"
}

# Define the mapping of cantons to their abbreviations
CANTON_ABBR = {
  "Aargau" => "AG",
  "Appenzell A.-Rh." => "AR",
  "Appenzell I.-Rh." => "AI",
  "Basel-Landschaft" => "BL",
  "Basel-Stadt" => "BS",
  "Bern" => "BE",
  "Freiburg" => "FR",
  "Genf" => "GE",
  "Glarus" => "GL",
  "Graubünden" => "GR",
  "Jura" => "JU",
  "Luzern" => "LU",
  "Neuenburg" => "NE",
  "Nidwalden" => "NW",
  "Obwalden" => "OW",
  "St. Gallen" => "SG",
  "Schaffhausen" => "SH",
  "Schwyz" => "SZ",
  "Solothurn" => "SO",
  "Thurgau" => "TG",
  "Tessin" => "TI",
  "Uri" => "UR",
  "Wallis" => "VS",
  "Waadt" => "VD",
  "Zug" => "ZG",
  "Zürich" => "ZH"
}

def import_people_from_csv(file_path)
  # Read the CSV file
  CSV.foreach(file_path, headers: true) do |row|
    # Extract the needed fields
    first_name = row['first_name'].strip
    last_name = row['last_name'].strip
    canton = CANTON_ABBR[row['canton_de']].strip
    party = PARTY_ABBR[row['party_de'].strip]
    birth_date = Date.strptime(row['birth_date'], '%d.%m.%Y')
    
    councils = []
    councils << 'NR' if row['NR_de'] == 'Nationalrat'
    councils << 'SR' if row['SR_de'] == 'Ständerat'
    council_str = councils.join('+')

    # Create the new person
    person = Person.create!(
      first_name: first_name,
      last_name: last_name,
      date_of_birth: birth_date,
      canton: canton,
      party: party,
      office: council_str
    )

    # Extract and save responses
    (1..14).each do |question_id|
      content = row["Q#{question_id}"].strip
      next if content.nil? || content.strip.empty?

      Response.create!(
        content: content,
        survey_id: 1,
        person_id: person.id,
        question_id: question_id
      )
    end
  end
end

import_people_from_csv(Rails.root.join('db/new_people.csv'))
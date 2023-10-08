require 'csv'

# Read votations CSV file and store the data in a hash for quick reference
votations = {}
CSV.foreach(Rails.root.join('db/vote_info_sr.csv'), headers: true) do |row|
  votations[row['vote_var']] = Votation.find_by(reference: row['vote_nr'])
end

# Define the mapping of party names to their abbreviations
party_abbr = {
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
  "Ensemble à Gauche" => "EAG"
}

# Define the mapping of group names to their abbreviations
group_abbr = {
  "Fraktion der Schweizerischen Volkspartei" => "V",
  "Sozialdemokratische Fraktion" => "S",
  "Die Mitte-Fraktion. Die Mitte. EVP." => "ME",
  "FDP-Liberale Fraktion" => "RL",
  "Grüne Fraktion" => "G",
  "Grünliberale Fraktion" => "GL",
}

# Define the mapping of cantons to their abbreviations
canton_abbr = {
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

CSV.foreach(Rails.root.join('db', 'ch_sr_par.csv'), headers: true) do |row|
  person = Person.new(
    first_name: row['first_name'],
    last_name: row['last_name'],
    canton: canton_abbr[row['canton_de']],
    party: party_abbr[row['party_de']],
    group: group_abbr[row['parl_group_de']],
    date_of_birth: Date.parse(row['birth_date']),
    office: "SR"
  )

  if person.save
    # Create the votes for this person
    row.headers.grep(/^v/).each do |header|
      next if row[header] == "NA"
      votation = votations[header]
      if votation.present?
        vote = person.votes.new(
          votation: votation,
          position: row[header].to_i
        )
        
        unless vote.save
          puts "Failed to save vote for header #{header}: #{vote.errors.full_messages}"
          puts person.first_name + ", " + person.last_name
        end
      else
        puts "No votation found for header #{header}"
      end
    end
  else
    puts "Failed to save person: #{person.errors.full_messages}"
  end
end

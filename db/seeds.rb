require 'faker'
require 'open-uri'
require 'tempfile'

Person.delete_all

CANTONS = {
  "AG" => "Aargau",
  "AR" => "Appenzell Ausserrhoden",
  "AI" => "Appenzell Innerrhoden",
  "BL" => "Basel-Landschaft",
  "BS" => "Basel-Stadt",
  "BE" => "Bern",
  "FR" => "Freiburg",
  "GE" => "Genf",
  "GL" => "Glarus",
  "GR" => "Graubünden",
  "JU" => "Jura",
  "LU" => "Luzern",
  "NE" => "Neuenburg",
  "NW" => "Nidwalden",
  "OW" => "Obwalden",
  "SG" => "St. Gallen",
  "SH" => "Schaffhausen",
  "SZ" => "Schwyz",
  "SO" => "Solothurn",
  "TG" => "Thurgau",
  "TI" => "Tessin",
  "UR" => "Uri",
  "VS" => "Wallis",
  "VD" => "Waadt",
  "ZG" => "Zug",
  "ZH" => "Zürich"
}

PARTIES = {
  "SVP" => "Schweizerische Volkspartei",
  "SP" => "Sozialdemokratische Partei der Schweiz",
  "FDP" => "FDP.Die Liberalen",
  "CVP" => "Christlichdemokratische Volkspartei",
  "GPS" => "Grüne Partei der Schweiz",
  "GLP" => "Grünliberale Partei",
  "BDP" => "Bürgerlich-Demokratische Partei",
  "EVP" => "Evangelische Volkspartei",
  "EDU" => "Eidgenössisch-Demokratische Union",
  "PdA" => "Partei der Arbeit der Schweiz",
  "SD" => "Schweizer Demokraten",
  "MCR" => "Mouvement Citoyens Romands",
  "LEGA" => "Lega dei Ticinesi"
}

GROUPS = {
  "V" => "Fraktion der Schweizerischen Volkspartei",
  "S" => "Sozialdemokratische Fraktion",
  "ME" => "Die Mitte-Fraktion. Die Mitte. EVP.",
  "RL" => "FDP-Liberale Fraktion",
  "G" => "Grüne Fraktion",
  "GL" => "Grünliberale Fraktion"
}

OFFICES = %w(SR NR)


range = (0..250).step(0.5).to_a



200.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
  
    person = Person.new(
      first_name: first_name,
      last_name: last_name,
      party: PARTIES.keys.sample,
      canton: CANTONS.keys.sample,
      date_of_birth: Faker::Date.between(from: 60.years.ago, to: 20.years.ago),
      group: GROUPS.keys.sample,
      office: OFFICES.sample,
      points: range[rand(0..range.size-1)]
    )
  
    person.slug = "#{person.first_name.parameterize}-#{person.last_name.parameterize}-#{person.canton}"
  
    gender = ["male", "female"].sample
    avatar_url = "https://xsgames.co/randomusers/avatar.php?g=#{gender}"

    begin
    file = URI.open(avatar_url)

    person.image.attach(
        io: file,
        filename: "#{person.slug}.jpg",
        content_type: 'image/jpeg'
    )
    rescue StandardError => e
        puts "Error downloading image: #{e.message}"
    end
  
    person.save
  end




AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
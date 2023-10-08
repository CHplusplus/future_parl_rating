require 'csv'

#Nationalrat
csv_text = File.read(Rails.root.join('db', 'vote_info_cn.csv'), encoding: 'UTF-8')
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  # Find the existing Business by shortnumber
  business = Business.find_by(shortnumber: row['object_nr'])

  # Check if the business is found
  if business
    # Create a new Votation associated with the Business
    votation = Votation.new
    votation.business = business
    votation.idealposition = row['ideal_position']
    votation.weight = row['weight']
    votation.reference = row['vote_nr']
    votation.explanation_de = row['expl_de']
    votation.explanation_fr = row['expl_fr']
  
    if votation.save
      puts "Votation for #{business.title_de}, saved"
    else
      puts "Failed to save votation for #{business.title_de}"
    end
  else
    puts "Business with shortnumber #{row['object_nr']} not found"
  end
end

#Ständerat
csv_text = File.read(Rails.root.join('db', 'vote_info_sr.csv'), encoding: 'UTF-8')
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  # Find the existing Business by shortnumber
  business = Business.find_by(shortnumber: row['object_nr'])

  # Check if the business is found
  if business
    # Create a new Votation associated with the Business
    votation = Votation.new
    votation.business = business
    votation.idealposition = row['ideal_position']
    votation.weight = row['weight']
    votation.reference = row['vote_nr']
    votation.explanation_de = row['expl_de']
    votation.explanation_fr = row['expl_fr']
  
    if votation.save
      puts "Votation for #{business.title_de}, saved"
    else
      puts "Failed to save votation for #{business.title_de}"
    end
  else
    puts "Business with shortnumber #{row['object_nr']} not found"
  end
end

puts "There are now #{Votation.count} rows in the Votation table"

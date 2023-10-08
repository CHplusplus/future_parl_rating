require 'csv'

BUSINESS_TYPES_MAPPING = {
  'Motion' => :business_type1,
  'Postulat' => :business_type2,
  'Geschäft des Bundesrates' => :business_type3,
  'Parlamentarische Initiative' => :business_type4
}.freeze

def process_csv(csv_text)
  csv = CSV.parse(csv_text, headers: true)
  
  csv.each do |row|
    unless Business.exists?(shortnumber: row['object_nr'])
      t = Business.new
      t.shortnumber = row['object_nr']
      
      german_typename = row['object_type']
      type_enum = BUSINESS_TYPES_MAPPING[german_typename]

      unless type_enum
        puts "WARNING: Unexpected typename '#{german_typename}' found in the import file!"
        next
      end

      t.business_type = type_enum
      t.title_de = row['Titel DE']
      t.title_fr = row['Titel FR']
      t.title_it = row['Titel IT']
      t.link_de = row['Link DE']
      t.link_fr = row['Link FR']
      t.link_it = row['Link IT']
      t.save
      puts "#{t.title_de}, saved"
    end
  end
end

#Nationalrat
csv_text_nr = File.read(Rails.root.join('db', 'vote_info_cn.csv'), encoding: 'UTF-8')
process_csv(csv_text_nr)

#Ständerat
csv_text_sr = File.read(Rails.root.join('db', 'vote_info_sr.csv'), encoding: 'UTF-8')
process_csv(csv_text_sr)

puts "There are now #{Business.count} rows in the Business table"

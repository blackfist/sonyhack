require 'sinatra'
require 'csv'

csv_text = File.read("freqs.csv")
freqs = CSV.parse(csv_text, headers: true)

def getActor(inTable)
  # roll to see who the actor is
  roll = rand()
  inTable.each do |row|
    temp = row.to_hash
    if roll <= temp['cum_freq'].to_f
      return temp
    end
  end
end

def to_sentence(inArray)
  case inArray.length
    when 0
      return ""
    when 1
      return "#{inArray[0]}"
    when 2
      return "#{inArray[0]} and #{inArray[1]}"
    else
      "#{inArray[0...-1].join(', ')}, and #{inArray[-1]}"
  end
end

SECURITY_VENDORS = ["Verizon", "Norse", "Crowdstrike",
  "iDefense", "Mandiant/FireEye", "Dell SecureWorks",
  "McAfee", "Symantec", "Kaspersky Labs", "Palo Alto Networks",
  "Fortinet", "iSIGHT Partners", "Check Point", "Arbor Networks",
  "Qualys", "Trend Micro", "Veracode"]

get '/' do
  @actor = getActor(freqs)
  @how_many_researchers = rand(2..10)
  @vendors = to_sentence(SECURITY_VENDORS.sample(rand(1..@how_many_researchers)))

  erb :index
end

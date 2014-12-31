require 'sinatra'
require 'csv'
require 'facets/string/titlecase'
require 'digest'


freqs = CSV.parse(File.read("freqs.csv"), headers: true)
doubters = CSV.parse(File.read("thomases.csv"), headers:true)
supporters = CSV.parse(File.read("supporters.csv"), headers:true)
countries = CSV.parse(File.read("countries.csv"), headers: true)

def getRow(inTable)
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
  @actor = getRow(freqs)
  @how_many_researchers = rand(2..10)
  @vendors = to_sentence(SECURITY_VENDORS.sample(rand(1..@how_many_researchers)))
  @doubter = doubters[rand(0..doubters.length-1)].to_hash
  @supporter = supporters[rand(0..supporters.length-1)].to_hash
  @country = getRow(countries)

  erb :index
end

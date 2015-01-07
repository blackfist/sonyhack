require 'sinatra'
require 'sinatra/content_for'
require 'csv'
require 'facets/string/titlecase'
require 'digest'


freqs = CSV.parse(File.read("freqs.csv"), headers: true)
doubters = CSV.parse(File.read("thomases.csv"), headers:true)
supporters = CSV.parse(File.read("supporters.csv"), headers:true)
countries = CSV.parse(File.read("countries.csv"), headers: true)
trueIOC = CSV.parse(File.read("true_ioc.csv"), headers: true)
fakeIOC = CSV.parse(File.read("ioc.csv"), headers: true)
subjects = CSV.parse(File.read("subject_lines.csv"), headers: true)

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

def getRandomIPs(inTable, inCountry)
  knownBad = ['203.131.222.102','217.96.33.165','88.53.215.64','200.87.126.116','58.185.154.99','212.31.102.100','208.105.226.235']
  returnArray = []

  inTable.each do |row|
    if row['iso2c'] == inCountry
      row['ip'].split(';').each do |ip|
        returnArray << {ip: ip, description: "Communicating with #{knownBad.sample(1)[0]}"}
      end
    end
  end
  returnArray[-1][:description] = "Logged into pastebin using the \"GuardiansOfPeace\" login id."
  returnArray
end

SECURITY_VENDORS = ["Verizon", "Norse", "Crowdstrike",
  "iDefense", "Mandiant/FireEye", "Dell SecureWorks",
  "McAfee", "Symantec", "Kaspersky Labs", "Palo Alto Networks",
  "Fortinet", "iSIGHT Partners", "Check Point", "Arbor Networks",
  "Qualys", "Trend Micro", "Veracode", "RSA", "Cylance", "F-Secure",
  "Proofpoint", "Microsoft", "Sophos", "Adallom", "AlienVault", "Secunia", "Cyphort"]

MONTHS = ["January", "February", "March", "April", "May", "June", "July",
  "August", "September", "October", "November", "December"]

get '/' do
  @actor = getRow(freqs)
  @how_many_researchers = rand(2..10)
  @vendors = to_sentence(SECURITY_VENDORS.sample(rand(1..@how_many_researchers)))
  @doubter = doubters[rand(0..doubters.length-1)].to_hash
  @supporter = supporters[rand(0..supporters.length-1)].to_hash
  @country = getRow(countries)
  @anotherCountry = getRow(countries)
  @previousAttackMonth = MONTHS.sample(1)[0]
  @fakeIPs = getRandomIPs(fakeIOC, @country['abr'])
  @trueIPS = []
  trueIOC.each do |row|
    @trueIPS << row.to_hash
  end
  @randomSubject = subjects[rand(0..subjects.length-1)].to_hash


  erb :index
end

not_found do
  status 404
  erb :oops
end

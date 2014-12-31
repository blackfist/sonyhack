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

get '/' do
  @actor = getActor(freqs)
  @how_many_researchers = rand(2..10)
  erb :index
end

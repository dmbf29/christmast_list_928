require 'csv'

def load_csv
  # return a hash of the gift list
  filepath = 'gifts.csv'
  # TODO: build new gift list
  gift_list = {}
  CSV.foreach(filepath, headers: :first_row, header_converters: :symbol) do |row|
    # add each item into the gift_list
    item = row[:item]
    purchased = row[:purchased] == 'true'
    gift_list[item] = purchased
  end
  return gift_list
end

def save_csv(gift_list)
  filepath = 'gifts.csv'
  CSV.open(filepath, 'wb') do |csv|
    # We add headers to the CSV
    csv << ['item', 'purchased']
    # iterate over your gift list and write into the csv file
    gift_list.each do |item, purchased|
      csv << [item, purchased]
    end
  end
end

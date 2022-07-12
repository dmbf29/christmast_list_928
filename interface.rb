require_relative 'scraper'
require_relative 'csv'
# initialize gift_list
gift_list = load_csv

def display_list(gift_list)
  gift_list.each_with_index do |(item, purchased), index|
    x_mark = purchased ? "X" : " "
    puts "#{index + 1} - [#{x_mark}] #{item}"
  end
end

puts "Welcome to the Christmas List"
choice = nil
until choice == 'quit'
  puts 'Which action [list|add|mark|idea|delete|quit]?'
  choice = gets.chomp
  case choice
  when 'list'
    display_list(gift_list)
  when 'add'
    # Ask the user for the new item
    # item = store user input
    # add the new item into our gift_list (hash) => hash[key] = value (set false as default)
    # tell the user the item was added to the list
    puts "What gift would you like to add?"
    item = gets.chomp
    gift_list[item] = false
    puts "#{item.capitalize} was added to your list!"
    save_csv(gift_list)
  when 'mark'
    display_list(gift_list)
    # ask the user for the number of the item
    # index = store the user's input -> change to integer AND subtract 1
    # item = somehow... we need to find the item with the index
    puts 'What number have you bought?'
    index = gets.chomp.to_i - 1
    items = gift_list.keys
    item = items[index]
    # hash[key] = new_value
    # gift_list[item] = true # this is okay too
    gift_list[item] =  !gift_list[item]
    puts "#{item} has been updated..."
    save_csv(gift_list)
  when 'delete'
    display_list(gift_list)
    # ask the user for the number of the item
    # index = store the user's input -> change to integer AND subtract 1
    # item = somehow... we need to find the item with the index
    # remove that item from the hash => hash.delete(key)
    # tell user the item was removed from the list
    puts 'What number do you want to delete?'
    index = gets.chomp.to_i - 1
    items = gift_list.keys
    item = items[index]
    gift_list.delete(item)
    puts "#{item} was removed from the list..."
    save_csv(gift_list)
  when 'idea'
    # ask the user what they are searching for
    puts 'What are you looking for on Etsy?'
    # keyword = get the user input
    keyword = gets.chomp
    # etsy_items = call the scraper method and give the keyword as an argument
    etsy_items = scrape_etsy(keyword)
    # give the items to the display_list method
    display_list(etsy_items)
    # ask the user which item they'd like to save into the gift_list
    puts 'Pick one to add to your list (give the number)'
    index = gets.chomp.to_i - 1
    # items = get all the keys from the etsy list
    items = etsy_items.keys
    # item = get the one item from the etsy keys
    item = items[index]
    # add that item into our gift_list
    gift_list[item] = false
    # tell user that item was added
    puts "#{item} was imported into your gift list..."
    save_csv(gift_list)
  when 'quit'
    puts 'Goodbye'
  else
    puts 'Wrong action'
  end
end

# Step 2 -> List
# iterate over our gift_list (hash) .each_with_index do |(item, purchased), index|
#     "1 - [ ] new bike"

# Step 2 -> Add
# Ask the user for the new item
# item = store user input
# add the new item into our gift_list (hash) => hash[key] = value (set false as default)
# tell the user the item was added to the list

# Step 2 -> Delete
# ask the user for the number of the item
# index = store the user's input -> change to integer AND subtract 1
# item = somehow... we need to find the item with the index
# remove that item from the hash => hash.delete(key)
# tell user the item was removed from the list

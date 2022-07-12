require 'nokogiri'
require 'open-uri'

def scrape_etsy(keyword)
  # filepath = "lib/results.html"
  # 1. We get the HTML page content
  # html_content = File.open(filepath)
  html_content = URI.open("https://www.etsy.com/search?q=#{keyword}").read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)

  # build an empty hash
  etsy_items = {}
  doc.search('.v2-listing-card__info .v2-listing-card__title').first(5).each do |element|
    # TODO: We SHOULD NOT puts here.
    # fill the hash with each item
    item = element.text.strip
    etsy_items[item] = false
  end
  return etsy_items
end

# we will call this method in our interface file. (aka our "idea" case statement)
# scrape_etsy('jeans')
# return an hash of items (that looks identical to our gift_list
# {'mom jeans' => false}

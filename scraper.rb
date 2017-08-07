require 'open-uri'
require 'nokogiri'
require 'scraperwiki'

ScraperWiki.config = { db: 'data.sqlite', default_table_name: 'data' }

results = []

1.times do |i|
  doc = Nokogiri::HTML(open('https://www.bundlestars.com/api/products?page='+i.to_s+'&types=game,dlc&sale=true'))
  doc.css('.search_result_row').each do |game|
    price_el = game.at_css('.search_price')
    price_el.children.each { |c| c.remove if c.name == 'span' }
    price = price_el.text.strip.split(' ')[0]
    id = game["data-ds-appid"].to_i
    puts id, price
    results.push({id: id, price: price})
  end
end

results.each do |result|
  ScraperWiki.save_sqlite([:id], result)
end

require 'open-uri'
require 'nokogiri'
require 'scraperwiki'

ScraperWiki.config = { db: 'data.sqlite', default_table_name: 'data' }

results = []

1.times do |i|
  doc = Nokogiri::HTML(open('https://www.bundlestars.com/api/products?page='+i.to_s+'&types=game,dlc&sale=true'))
  doc.css('.bs-card-body').each do |game|
logger.error "Something blew up!"
  end
end

results.each do |result|
  ScraperWiki.save_sqlite([:id], result)
end

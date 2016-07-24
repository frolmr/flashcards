require 'nokogiri'
require 'open-uri'

start_page = Nokogiri::HTML(open('http://www.languagedaily.com/learn-german/vocabulary/common-german-words'))

get_all_links = start_page.css('a').map { |link| link['href'] }.uniq

get_required_links = get_all_links.select { |link| link =~ %r{\A/learn-german/vocabulary/[a-z-]*\d*\z} }.map { |link| 'http://www.languagedaily.com' + link }

result = {}
get_required_links.each do |url|
  page = Nokogiri::HTML(open(url))
  original_words = page.css('td.bigLetter').map(&:text)
  translated_text = page.css('td.bigLetter + td').map(&:text)
  result.merge!(original_words.zip(translated_text).to_h)
end

result.delete_if { |_key, value| value =~ /\u00A0/ }

result.each do |original, translated|
  Card.create(original_text: original, translated_text: translated)
  puts "*New record:\n #{original} -> #{translated}\nwas created in DB"
end

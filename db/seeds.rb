require 'nokogiri'
require 'open-uri'

user = User.create(email: 'testr@user.ru', password: 'foobar')

start_page = Nokogiri::HTML(open('http://www.languagedaily.com/learn-german/vocabulary/common-german-words'))

get_all_links = start_page.css('a').map { |link| link['href'] }.uniq

get_required_links = get_all_links.select { |link| link =~ %r{\A/learn-german/vocabulary/[a-z-]*\d*\z} }.map { |link| 'http://www.languagedaily.com' + link }

get_required_links.each do |url|
  page = Nokogiri::HTML(open(url))
  page.css('tr').drop(1).each do |word|
    Card.create(original_text: word.xpath('td[2]').text, translated_text: word.xpath('td[3]').text, user_id: user.id) if word.xpath('td[3]').text !~ /\u00A0/
  end
end

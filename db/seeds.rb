require 'nokogiri'
require 'open-uri'

DOMAIN = 'http://www.languagedaily.com'
START_PAGE = DOMAIN + '/learn-german/vocabulary/common-german-words'
SEARCH_PATTERN = /\A\/learn-german\/vocabulary\/[a-z-]*\d*\z/
ORIGINAL_WORD_TAG = 'td.bigLetter'
TRANSLATED_TEXT_TAG = 'td.bigLetter + td'
EMPTY_STRING_PATTERN = /\u00A0/

def open_page(link)
  Nokogiri::HTML(open(link))
end

def get_links_hrefs(page)
  page.css('a').map{ |link| link['href']}.uniq
end

def find_required_links (links, link_pattern)
  links.find_all{ |link| link =~ link_pattern }.map { |link| link = DOMAIN + link }
end

def get_element_text(element)
  element.map{ |word| word.text }
end

def get_all_words_from_all_pages(route)
  result = {}
  route.each do |url|
    current_page = open_page(url)
    result.merge!(find_words(current_page))
  end
  result
end

def find_words(page)
  original_words = get_element_text(page.css(ORIGINAL_WORD_TAG))
  translated_text = get_element_text(page.css(TRANSLATED_TEXT_TAG))
  original_words.zip(translated_text).to_h
end

def remove_empty_words(words, empty_string_pattern)
  words.delete_if { |key, value| value =~ empty_string_pattern }
end

page = open_page(START_PAGE)
links = get_links_hrefs(page)
route = find_required_links(links, SEARCH_PATTERN)
words = get_all_words_from_all_pages(route)
result = remove_empty_words(words, EMPTY_STRING_PATTERN)

result.each do |original, translated|
  Card.create(original_text: original, translated_text: translated)
  puts "*New record:\n #{original} -> #{translated}\nwas created in DB"
end
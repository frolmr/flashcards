class FlickrSearch
  require 'flickraw-cached'

  FlickRaw.api_key = ENV['FLICKR_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']

  def search_photos_urls(search_request, per_page = 10)
    flickr.photos.search(text: search_request, per_page: per_page, format: 'json').map { |photo| FlickRaw.url_m(photo) }
  end
end

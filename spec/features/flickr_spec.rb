require 'rails_helper'
require 'spec_helper'

describe Dashboard::CardsController do
  card = Card.create(original_text: '', translated_text: 'house', user_id: 1, deck_id: 1)
  context 'Flickr find button' do

    let(:photos_list) do
    { "photos": { "page": 1, "pages": 15, "perpage": 100, "total": "1490",
    "photo": [
      { "id": "31674026883", "owner": "90535065@N03", "secret": "ac64d86bda", "server": "548", "farm": 1, "title": "test123", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32444813946", "owner": "90535065@N03", "secret": "a19cd9d262", "server": "296", "farm": 1, "title": "test123", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32363880061", "owner": "91815662@N04", "secret": "2c8acd29dc", "server": "534", "farm": 1, "title": "test", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32106824410", "owner": "141416318@N03", "secret": "f5ba02116b", "server": "719", "farm": 1, "title": "Lee Test Session0535-2", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32363792331", "owner": "90535065@N03", "secret": "bc853e7f23", "server": "746", "farm": 1, "title": "test123", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32444716086", "owner": "12210748@N06", "secret": "39676880fe", "server": "766", "farm": 1, "title": "test", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32363490311", "owner": "151337187@N06", "secret": "53b62467fa", "server": "690", "farm": 1, "title": "Samsung Galaxy J7 Prime - Water Test! (4K) - https:\/\/t.co\/zQM4132OuJ Galaxy J7 Prime - Water Test! (4K)", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32485078005", "owner": "95978154@N02", "secret": "05d7f7b087", "server": "332", "farm": 1, "title": "37608 T&T 37604  1Q05 0612 Derby RTC - Tees N.Y. Test Train  (  Passing Thornaby  23.1.2017 )", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32333353232", "owner": "59244826@N04", "secret": "ba5db47564", "server": "401", "farm": 1, "title": "Fidra Island", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "32363361171", "owner": "59244826@N04", "secret": "5d020ed30e", "server": "620", "farm": 1, "title": "Yellowcraig  Beach, East Lothian", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
    ] }, "stat": "ok" }.to_json
    end

    before(:each) do
      stub_request(:post, 'https://api.flickr.com/services/rest/').
      with(body: { format: 'json', method: 'flickr.photos.search', nojsoncallback: '1', per_page: '10', text: 'test' }).
      and_return(body: photos_list)
    end

    it 'should call flickr.search request' do
      FlickrSearch.new.search_photos_urls('test')
      expect(a_request(:post, "https://api.flickr.com/services/rest/").
      with(body: { format: 'json', method: 'flickr.photos.search', nojsoncallback: '1', per_page: '10', text: 'test' })).
      to have_been_made.once
    end

    it 'should return array of photos' do
      urls = FlickrSearch.new.search_photos_urls('test')
      expect(urls).to be_instance_of(Array)
      expect(urls.length).to eq 10
    end
  end
end

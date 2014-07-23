class HomeController < ApplicationController
  def index
    @featured_events = []
    @featured_events.push HTTParty.get("http://api.songkick.com/api/3.0/events/19369714.json?apikey=UqncZSiBYPTv4CI0").parsed_response["resultsPage"]["results"]["event"]
    @featured_events.push HTTParty.get("http://api.songkick.com/api/3.0/events/19260149.json?apikey=UqncZSiBYPTv4CI0").parsed_response["resultsPage"]["results"]["event"]
    @featured_events.push HTTParty.get("http://api.songkick.com/api/3.0/events/16767699.json?apikey=UqncZSiBYPTv4CI0").parsed_response["resultsPage"]["results"]["event"]
  end
  def playlist
    artist = ActiveSupport::Inflector.transliterate params[:artist]
    @obj = GetSetlist.new(artist)
    @setlist = @obj.setlist
    @youtube_urls = []
    @youtube_titles = []
    @setlist.each do |track|
      url = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet%20&q=#{ActiveSupport::Inflector.transliterate(track['name']).gsub(/ /, '+')}+#{artist.gsub(/ /, '+')}&type=video%20&key=AIzaSyCBGQLzcTJ5zjLLG02IcupdqsW93JeKNZA").parsed_response["items"][0]["id"]["videoId"]
      if url
        @youtube_urls.push url
        @youtube_titles.push track['name']
      end
    end
  end
  def about
  end
end

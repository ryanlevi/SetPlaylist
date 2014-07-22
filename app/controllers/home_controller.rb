class HomeController < ApplicationController
  def index
  end
  def playlist
    @setlist = GetSetlist.new(params[:artist]).setlist
    @youtube_urls = []
    @youtube_titles = []
    @setlist.each do |track|
      @youtube_titles.push track['name']
      url = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet%20&q=#{track['name'].gsub(/ /, '+')}+#{params[:artist].gsub(/ /, '+')}&type=video%20&key=AIzaSyCBGQLzcTJ5zjLLG02IcupdqsW93JeKNZA").parsed_response["items"][0]["id"]["videoId"]
      @youtube_urls.push url
    end
  end
end

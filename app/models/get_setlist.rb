class GetSetlist
  def initialize(artist)
    @response = HTTParty.get "http://api.setlist.fm/rest/0.1/search/setlists?artistName=#{artist.gsub(/ /, '+')}"
    if @response==nil
      return
    end
    if @response.parsed_response["setlists"]
      @setlists = @response.parsed_response["setlists"]["setlist"]
    else
      return
    end
    i=0
    while !@setlists[i]["sets"]
      i = i + 1
    end
    @set = @setlists[i]
    @artist = @set["artist"]["name"]
    @venue = @set["venue"]["name"]
    @date = @set["eventDate"].to_date
    if @set["sets"]["set"][0]
      @setlist = @set["sets"]["set"][0]["song"]
    elsif @setlists[i]["sets"]["set"]
      @setlist = @set["sets"]["set"]["song"]
    else
      return
    end
  end
  def setlist
    @setlist
  end
  def artist
    @artist
  end
  def venue
    @venue
  end
  def date
    @date
  end
end
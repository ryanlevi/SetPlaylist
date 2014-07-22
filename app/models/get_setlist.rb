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
    if @setlists[i]["sets"]["set"][0]
      @setlist = @setlists[i]["sets"]["set"][0]["song"]
    elsif @setlists[i]["sets"]["set"]
      @setlist = @setlists[i]["sets"]["set"]["song"]
    else
      return
    end
  end
  def setlist
    @setlist
  end
end
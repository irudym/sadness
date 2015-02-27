class SadnessController < ApplicationController
  require 'open-uri'

  def new
  end

  def create
  end

  def show
  end

  # GET
  def depress
    url = params[:link_to]
    #analyze the url
    #for this version I will use http://www.lyricsmode.com/lyrics/k/kaleida/think.html
    page = Nokogiri::HTML(open(url, "User-Agent" => "Chrome"))
    lyrics = page.css('p#lyrics_text').text.gsub(/\s+/m,' ').strip.split(' ')
    respond_to do |format|
      @text = lyrics
      format.html {render 'show'}
    end
  end

  private
  def get_sadness_param
    params.require(:sadness).permit(:link_to)
  end
end

class SadnessController < ApplicationController
  require 'open-uri'

  def new
  end

  def create
  end

  def show
  end

  # POST
  def depress
    url = params[:link_to] || session[:link_to]

    #analyze the url
    #for this version I will use http://www.lyricsmode.com/lyrics/k/kaleida/think.html
    page = Nokogiri::HTML(open(url, "User-Agent" => "Chrome"))

    div = 'p#lyrics_text' if url.match(/lyricsmode.com/)
    div = 'p#songLyricsDiv' if url.match(/songlyrics.com/)
    div = 'div#lyrics-body-text' if url.match(/metrolyrics.com/)

    text_hash = Word.text_to_words(page.css(div).text)

    respond_to do |format|

      missed_words = Word.missed_words(text_hash)
      if missed_words.size > 0
        # add missed words to database
        missed_words.each do |word|
          Word.create(word: word) unless Word.where(word: word).first
        end
        session[:link_to] = url
        format.html {redirect_to :words_edit_words}
      else
        sad, word_count, @sadness_map = Word.sadness_calculator text_hash
        @text = text_hash.to_a
        @sadness = [sad,word_count,sad/word_count]

        @sadness_map.delete_at(2)
        @sadness_map.map! do |e|
          ((e.to_f/word_count.to_f)*100.0).round
        end
        # fix the 100% split
        @sadness_map[2]  = 100 - (@sadness_map[0] + @sadness_map[1] + @sadness_map[3])
        format.html {render 'show'}
      end
    end
  end


  private
  def get_sadness_param
    params.require(:sadness).permit(:link_to)
  end
end

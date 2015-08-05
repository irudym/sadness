class WordsController < ApplicationController

  def new
  end

  def create
  end

  def edit_words
    @words = Word.where(sadness: nil).order('word ASC')
  end

  def update
    #update the word record
    word = Word.find(params[:id])
    word.update(get_word_params)
    respond_to do |format|
      if(word.save!)
        format.html { redirect_to :sadness_depress }
      else
        #should forward to error page!
        format.html { redirect_to :update }
      end
    end
  end

  def update_words
    #update words
    @words = Word.where(sadness: nil).order('word ASC')
    @words.each do |word|
      word.update!(sadness: params[word[:id].to_s]) if params[word[:id].to_s]
    end
    @words = Word.where(sadness: nil).order('word ASC')
    respond_to do |format|
      if @words.first
        format.html {render 'edit_words'}
      else
        format.html { redirect_to :sadness_depress }
      end
    end
  end

  def show
  end

  private
  def get_word_params
    params.require(:word).permit(:sadness)
  end
end

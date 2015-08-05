require 'rails_helper'

describe Word do
  let(:sample_text) {"Don't worry be happy\nWhen you worry you are not happy"}
  let(:missed_text) {"Don't let me go!"}
  let(:sample_hash) {Word.text_to_words(sample_text)}
  it "splits a text to words hash data" do
    text_hash = Word.text_to_words(sample_text)
    expect(text_hash).to include({"do"=>1, "not"=>2, "worry"=>2, "be"=>1, "happy"=>2, "when"=>1, "you"=>2, "are"=>1})
  end

  context 'checking words' do
    it 'if they are in databased' do
      missed_words = Word.missed_words(sample_hash)
      expect(missed_words.size).to eq(0)
    end

    it 'creates a list of words which are not in databased' do
      missed_hash = Word.text_to_words(missed_text)
      expect(Word.missed_words(missed_hash).size).to eq(3)
    end
  end
end
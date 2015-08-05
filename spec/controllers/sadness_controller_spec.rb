require 'rails_helper'


describe SadnessController, type: :controller do
  let(:sample_text) {"Don't worry be happy\nWhen you worry you are not happy"}
  let(:sample_hash) {Word.text_to_words sample_text}

  it 'calculates overall sadness of the text' do
    result = Word.sadness_calculator(sample_hash)
    expect(result[0]).to eq(-2)
  end

  it 'calculates amount the words with sadness!=0' do
    result = Word.sadness_calculator(sample_hash)
    expect(result[1]).to eq(6)
  end
end
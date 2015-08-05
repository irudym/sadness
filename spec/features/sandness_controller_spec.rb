
describe "Real song" do
  context "analyzing" do
    it "checks a song" do
      visit '/'
      page.fill_in 'link_to', with: 'http://www.lyricsmode.com/lyrics/k/kaleida/think.html'
      page.click_link_or_button('commit')
      expect(page).to include(['58%','2%','40%'])
    end
  end
end
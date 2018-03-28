class Artist < ApplicationRecord
  has_many :musics

  #artist_event relationship
  has_many :shows, dependent: :destroy
  has_many :events, through: :shows

  #user followed
  has_many :artist_followships, dependent: :destroy
  has_many :artist_followed, through: :artist_followships, source: :user

  #user favorit
  has_many :favorits, dependent: :destroy
  has_many :favorited, through: :favorits, source: :user
end

def youtube(user)
  agent = Mechanize.new
  url = 'https://www.youtube.com/results?search_query=' + '許含光'
  page = agent.get(url)

  page.search('#thumbnail').attr('href').value

end

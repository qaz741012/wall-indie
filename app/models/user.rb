class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :spotify]

  #掛載carrierwave
  mount_uploader :avatar, PhotoUploader

  #follow event
  has_many :event_followships
  has_many :user_followed_events, through: :event_followships, source: :event

  #follow artist
  has_many :artist_followships, dependent: :destroy
  has_many :user_followed_artists, through: :artist_followships, source: :artist

  #favorits artist
  has_many :favorits, dependent: :destroy
  has_many :favorited_artists, through: :favorits, source: :artist

  #friends 自關聯
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :inverse_friendships, source: :user

  after_validation :default_avatar

  #若user.role = admin 回傳true
  def admin?
    self.role == "admin"
  end

  #friend and unfriend judgement
  def friend?(user)
    self.friends.include?(user)
  end

  #判斷user是否有follow某個artist
  def followed_this_artist?(artist)
    self.user_followed_artists.include?(artist)
  end

  #判斷user是否有favorite某個artist
  def favorited_this_artist?(artist)
    self.favorited_artists.include?(artist)
  end

  #判斷user是否有follow某個event
  def followed_this_event?(event)
    self.user_followed_events.include?(event)
  end

  #預設頭像
  def default_avatar
    if !self.avatar?
      self.remote_avatar_url = "http://www.gogecko.com.au/images/avatar.png"
      self.save
    end
  end

  # 處理facebook授權的資料
  def self.from_facebook_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid(auth.uid)
    if user
      user.fb_token = auth.credentials.token
      user.skip_confirmation!
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.provider = auth.provider
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.skip_confirmation!
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.provider = auth.provider
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.skip_confirmation!
    user.save!
    return user
  end

  # 處理spotify授權的資料
  def self.from_spotify_omniauth(auth)
    # Case 1: Find existing user by spotify uid
    user = User.find_by_spotify_uid(auth.uid)
    if user
      user.spotify_token = auth.credentials.token
      user.follow_artist_from_spotify(auth)
      user.skip_confirmation!
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.provider = auth.provider
      existing_user.spotify_uid = auth.uid
      existing_user.spotify_token = auth.credentials.token
      existing_user.follow_artist_from_spotify(auth)
      if !existing_user.avatar?
        existing_user.remote_avatar_url = auth.info.image
      end
      existing_user.skip_confirmation!
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.provider = auth.provider
    user.spotify_uid = auth.uid
    user.spotify_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.follow_artist_from_spotify(auth)
    user.remote_avatar_url = auth.info.image
    user.skip_confirmation!
    user.save!
    return user
  end

  def follow_artist_from_spotify(auth)
    user = RSpotify::User.new(auth)
    sp_artists = user.following(type: 'artist')  # 取得使用者在Spotify追蹤的artist
    sp_artists.each do |sp_artist|
      ## 建立artist

      artist = Artist.find_by_name(sp_artist.name)
      # Case 1: 如果artist存在，但沒圖片 => 存圖片
      if artist && !artist.photo?
        artist.photo = sp_artist.images[0]["url"]

      # Case 2: 如果artist不存在 => 存入artist
      elsif !artist
        artist = Artist.new
        artist.name = sp_artist.name
        artist.remote_photo_url = sp_artist.images[0]["url"]
      end
      artist.save

      ## 建立user-follow-artist關聯
      if !followed_this_artist?(artist)
        artist_followship = self.artist_followships.build(artist_id: artist.id)
      end
    end
  end

end

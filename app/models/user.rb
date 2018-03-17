class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :spotify]

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

  #若user.role = admin 回傳true
  def admin?
    self.role == "admin"
  end

  #friend and unfriend judgement
  def friends?(user)
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

  # 處理facebook授權的資料
  def self.from_facebook_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.skip_confirmation!
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.skip_confirmation!
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
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
    # Case 1: Find existing user by facebook uid
    user = User.find_by_spotify_uid( auth.uid )
    if user
      user.spotify_token = auth.credentials.token
      user.skip_confirmation!
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.spotify_uid = auth.uid
      existing_user.spotify_token = auth.credentials.token
      existing_user.skip_confirmation!
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.spotify_uid = auth.uid
    user.spotify_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.skip_confirmation!
    user.save!
    return user
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #follow event
  has_many :event_followships
  has_many :user_followed_events, through: :event_followships, source: :event

  #follow artist
  has_many :artist_followships
  has_many :user_followed_artists, through: :artist_followships, source: :artist

  #favorits artist
  has_many :favorits
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

end

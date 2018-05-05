class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  has_many :replies, dependent: :restrict_with_error
  has_many :replied_posts, through: :replies, source: :post

  has_many :vieweds, dependent: :restrict_with_error
  has_many :viewed_posts, through: :vieweds, source: :post

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :connect_friendships, -> {where status: 'connect'}, class_name: "Friendship", dependent: :destroy
  has_many :connect_friends, through: :connect_friendships, source: :friend

  has_many :beconnect_friendships, -> {where status: 'connect'}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :beconnect_friends, through: :beconnect_friendships, source: :user

  has_many :wait_friendships, -> {where status: 'send'}, class_name: "Friendship", dependent: :destroy
  has_many :wait_friends, through: :wait_friendships, source: :friend

  has_many :unconfirm_friendships, -> {where status: 'send'}, class_name: "Friendship", foreign_key: "friend_id"
  has_many :unconfirm_friends, through: :unconfirm_friendships, source: :user

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post

  def admin?
    self.role == "admin"
  end

  def add_friend?(user)
    self.friends.include?(user)
  end

  def beconnect_friends_ids(user) 
    self.beconnect_friends.ids << user.id #把自己加入
  end

  def all_friends
    self.connect_friends.all.uniq
  end

end

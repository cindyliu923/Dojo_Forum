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

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post

  def admin?
    self.role == "admin"
  end

  def friend?(user)
    self.friends.include?(user)
  end

end

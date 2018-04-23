class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :replies, dependent: :restrict_with_error
  has_many :replied_posts, through: :replies, source: :post

  has_many :vieweds, dependent: :restrict_with_error
  has_many :viewed_posts, through: :vieweds, source: :post

  def admin?
    self.role == "admin"
  end

end

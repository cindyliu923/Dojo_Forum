class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates_presence_of :title, :description
  validates_inclusion_of :status, :in => ["publish", "draft"]
  validates_inclusion_of :permit, :in => ["all", "friend", "myself"]

  belongs_to :user

  has_many :category_of_posts, dependent: :destroy
  has_many :categories, through: :category_of_posts

  has_many :replies, dependent: :destroy

  has_many :vieweds, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  def self.all_publish(user)
    if user.present?
      where( :status => 'publish').where('permit = ? AND posts.user_id = ? OR permit = ? OR permit = ? AND posts.user_id IN (?)', 'myself',user,'all','friend',user.beconnect_friends_ids(user))
    else
      where( :status => 'publish', :permit => 'all')
    end
  end

  def self.drafts
    where( :status => 'draft').all
  end

  def self.publishs
    where( :status => 'publish').all
  end  

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def last_replied_at
    self.replies.order(:created_at).last.created_at.to_date 
  end

  def permit_user?(user)
    self.permit == 'friend' && user.beconnect_friends_ids(user).include?(self.user.id) ||
    self.permit == 'myself' && self.user == user ||
    self.permit == 'all'
  end

end

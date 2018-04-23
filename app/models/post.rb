class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :replies, dependent: :destroy

  has_many :vieweds, dependent: :destroy

  def self.all_publish 
    where( :status => 'publish', :permit => 'all' ).all
  end

end

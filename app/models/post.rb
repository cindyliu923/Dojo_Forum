class Post < ApplicationRecord
  belongs_to :category

  has_many :replies, dependent: :destroy

end

class Category < ApplicationRecord
  validates_presence_of :name

  has_many :category_of_posts, dependent: :restrict_with_error
end

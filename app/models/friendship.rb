class Friendship < ApplicationRecord
  validates_inclusion_of :status, :in => ["send", "ignore", "connect"]
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :friend, class_name: "User"
end

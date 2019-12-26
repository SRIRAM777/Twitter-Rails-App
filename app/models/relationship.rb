class Relationship < ApplicationRecord

  belongs_to :follower, class_name: "User"
  belongs_to :followed_by, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_by_id, presence: true

end

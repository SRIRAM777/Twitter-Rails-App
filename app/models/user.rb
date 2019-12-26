class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :follower_relations, class_name:  "Relationship",
    foreign_key: "follower_id", dependent:   :destroy

  has_many :following, through: :follower_relations,  source: :followed_by

  has_many :followed_by_relations, class_name:  "Relationship",
    foreign_key: "followed_by_id", dependent:   :destroy

  has_many :followers, through: :followed_by_relations, source: :follower

  has_many :posts, dependent: :destroy

  # has_many :comments

  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def feed

    following_ids = "SELECT followed_by_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

end

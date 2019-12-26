class Comment < ApplicationRecord

  # belongs_to :post
  # has_one :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, :presence => true, :length => {:maximum => 140,:minimum => 3}

  # def commented_user_name commenter_id
  #   User.find_by_id(commenter_id).name
  # end

end

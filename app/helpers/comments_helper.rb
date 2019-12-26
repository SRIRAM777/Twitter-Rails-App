module CommentsHelper

  def commented_user_name commenter_id
    current_user.id == commenter_id ? 'You' : User.find_by_id(commenter_id).name
  end

end

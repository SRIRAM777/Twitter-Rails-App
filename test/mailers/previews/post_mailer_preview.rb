# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  def new_post_mail
    post = Post.new(content: "Test post for Mailer", user_id: 4)

    PostMailer.with(post: post).new_post_mail
  end
end

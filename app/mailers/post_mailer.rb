class PostMailer < ApplicationMailer

  def new_post_mail
    @post = params[:post]
    mail(to: @post['user_email'], subject: "Check out the new Posts!")
  end
end

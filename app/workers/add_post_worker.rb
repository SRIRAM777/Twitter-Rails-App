class AddPostWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(post_params)
    PostMailer.with(post: post_params).new_post_mail.deliver_later
  end

end
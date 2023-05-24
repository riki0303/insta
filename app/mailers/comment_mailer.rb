class CommentMailer < ApplicationMailer
  def new_comment(user)
    @user = user
    mail to: user.email, subject: '【新しいコメント】'
  end
end


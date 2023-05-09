class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    # フォローしているユーザーのidを配列で取得
    user_ids = current_user.followings.pluck(:id)
    # idを含むpostを取得
    @posts = Post.where(user_id: user_ids)
  end
end
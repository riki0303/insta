class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    # フォローしているユーザーのidを配列で取得
    user_ids = current_user.followings.pluck(:id)
    # idを含むpostを降順(DESC)で表示
    @posts = Post.where(user_id: user_ids).order(created_at: :desc)

    # 24時間以内の記事でいいねが多い順に3つ取得
    @like_posts = Post.left_joins(:likes).where('posts.created_at >= ?', 24.hours
      .ago).group(:id).order('COUNT(likes.id) DESC').limit(3)
  end
end

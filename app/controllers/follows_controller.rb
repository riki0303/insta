class FollowsController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:account_id])
    follow_status = current_user.has_followed?(user)
    followers_number = user.follower_relationships.count
    render json: { hasFollowed: follow_status, followersNumber: followers_number }
  end

  def create
    current_user.follow!(params[:account_id])
    user = User.find(params[:account_id])
    followers_number = user.follower_relationships.count
    render json: { status: 'ok', followersNumber: followers_number }
  end
end

class UnfollowsController < ApplicationController

  
  def create
    current_user.unfollow!(params[:account_id])
    user = User.find(params[:account_id])
    followers_number = user.follower_relationships.count
    render json: { status: 'ok', followersNumber: followers_number }

  end
end

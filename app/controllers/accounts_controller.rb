class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    return unless @user == current_user
    redirect_to profile_path

    
  end
end

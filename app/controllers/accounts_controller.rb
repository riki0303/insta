class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])
    return unless @user == current_user

    redirect_to profile_path
  end
end

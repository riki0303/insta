class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @profile = current_user.profile

    @posts = current_user.posts.all
  end

  # def newなくてもeditで2つの役割
  def edit
    @profile = current_user.profile || current_user.build_profile
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'Success!'
    else
      flash.now[:error] = 'Failure!'
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :avatar)
  end
end

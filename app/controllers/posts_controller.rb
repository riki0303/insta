class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  def index
    @posts = Post.all
  end

  # def show
  #   @post = Post.find(params[:id])
  # end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Success!'
    else
      flash.now[:error] = 'Failure!'
      render :new
    end
  end

  # def destroy
  #   post = current_user.posts.find(params[:id])
  #   post.destroy!
  #   redirect_to root_path, notice: '削除に成功しました'
  # end

  private

  def post_params
    params.require(:post).permit(:title, eyecatches: [])
  end
end

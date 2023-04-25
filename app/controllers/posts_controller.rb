class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

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

  private
  def post_params
    params.require(:post).permit(:title, eyecatches: [])
  end
end

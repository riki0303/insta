class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
    @comment.user_id = current_user.id
    # コメント一覧表示用
    @comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
     # render :newの後のコメント一覧表示用
    @comments = @post.comments
    if @comment.save
      redirect_to new_post_comment_path(@post), notice: 'Success!'
    else
      flash.now[:error] = 'Failure!'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
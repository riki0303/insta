class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
    # コメント一覧表示用
    @comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
     # render :newの後のコメント一覧表示用
    @comments = @post.comments
    if @comment.save
      redirect_to root_path, notice: 'Success!'
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
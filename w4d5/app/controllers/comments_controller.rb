class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    flash[:post_id] = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = flash[:post_id]

    if @comment.save
      redirect_to root_url
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content,
      :author_id,
      :post_id,
      :commentable_id,
      :commentable_type
    )
  end
end

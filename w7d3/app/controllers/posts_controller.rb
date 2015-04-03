class PostsController < ApplicationController
  def create
    @post = Post.new
    if @post.update(post_params)
      render :show
    else
      render json: @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def index
    @posts = Post.all
    render :index
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      render :show
    else
      render json: @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render :show
    else
      render json: @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

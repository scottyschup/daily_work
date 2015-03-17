class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
    flash.now[:sub_ids] = [params[:sub_id]]
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      flash.now[:sub_ids] = params[:post][:sub_ids]
      @subs = Sub.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    flash.now[:sub_ids] = @post.subs.pluck(:id).map(&:to_s)
    @subs = Sub.all
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      flash.now[:sub_ids] = params[:post][:sub_ids]
      @subs = Sub.all
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_author
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless @post.author_id == current_user.id
  end
end

class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]
  before_action :require_login, only: [:new, :create]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def index
    @subs = Sub.all
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy!
    redirect_to root_url
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_moderator
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless @sub.moderator_id == current_user.id
  end
end

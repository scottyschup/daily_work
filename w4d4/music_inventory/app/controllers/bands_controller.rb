class BandsController < ApplicationController
  before_action :require_current_user!
  
  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = [@band.errors.full_messages]
      render :new
    end
  end

  def index
    @bands = Band.all
    render :index
  end
end

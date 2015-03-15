class AlbumsController < ApplicationController
  before_action :require_current_user!
  
  def index
    @albums = Band.find(params[:band_id]).albums
    render :index
  end
end

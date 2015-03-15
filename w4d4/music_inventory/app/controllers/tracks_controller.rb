class TracksController < ApplicationController
  before_action :require_current_user!

  def index
    @tracks = Album.find(params[:album_id]).tracks
  end

end

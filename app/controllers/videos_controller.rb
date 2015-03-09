class VideosController < ApplicationController

  def show
    @video = BreakVideo.friendly.find(params[:id])
  end

end

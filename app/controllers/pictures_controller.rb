class PicturesController < ApplicationController

  def show
    @picture = RedditFunnyPicture.friendly.find(params[:id])
  end

end

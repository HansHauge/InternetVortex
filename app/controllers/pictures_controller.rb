class PicturesController < ApplicationController
  before_action :determine_source, only: [:show]

  def show
    @picture = @source.friendly.find(params[:id])
  end

  private

  def determine_source
    if source = params[:source]
      @source = RedditFunnyPicture if source.eql?('reddit.com/r/funny')
      @source = MemesPicture if source.eql?('memes.com')
    else
      guess_at_the_source
    end
  end

  def guess_at_the_source
    if RedditFunnyPicture.where(slug: params[:id]).present?
      @source = RedditFunnyPicture
    else
      @source = MemesPicture
    end
  end

end

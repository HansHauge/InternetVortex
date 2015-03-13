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
      @source = RedditAdviceAnimalsPicture if source.eql?('reddit.com/r/adviceanimals')
    else
      guess_at_the_source
    end
  end

  def guess_at_the_source
    if RedditFunnyPicture.where(slug: params[:id]).present?
      @source = RedditFunnyPicture
    elsif RedditAdviceAnimalsPicture.where(slug: params[:id]).present?
      @source = RedditAdviceAnimalsPicture
    else
      @source = MemesPicture
    end
  end

end

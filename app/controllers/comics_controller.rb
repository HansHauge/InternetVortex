class ComicsController < ApplicationController
  before_action :determine_source, only: [:show]

  def show
    @comic = @source.friendly.find(params[:id])
  end

  private

  def determine_source
    source = params[:source]
    @source = XkcdComic if source.eql?('xkcd.com')
  end
end

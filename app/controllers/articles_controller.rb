class ArticlesController < ApplicationController
  before_action :determine_source, only: [:show]

  def show
    @article = @source.friendly.find(params[:id])
  end

  private

  def determine_source
    if source = params[:source]
      @source = FailblogArticle if source.eql?('failblog.cheezburger.com')
      @source = MemebaseArticle if source.eql?('memebase.cheezburger.com')
    else
      guess_at_the_source
    end
  end

  def guess_at_the_source
    if MemebaseArticle.where(slug: params[:id]).present?
      @source = MemebaseArticle
    else
      @source = FailblogArticle
    end
  end
end

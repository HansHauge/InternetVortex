class ArticlesController < ApplicationController
  before_action :determine_source, only: [:show]

  def show
    @article = @source.friendly.find(params[:id])
  end

  private

  def determine_source
    source = params[:source]
    @source = FailblogArticle if source.eql?('failblog.cheezburger.com')
    @source = MemebaseArticle if source.eql?('memebase.cheezburger.com')
  end
end

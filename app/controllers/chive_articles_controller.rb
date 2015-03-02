class ChiveArticlesController < ApplicationController
  def index
    @chive_articles = ChiveArticle.last(20)
  end
end

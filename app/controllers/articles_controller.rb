class ArticlesController < ApplicationController
  def index
    chive_articles = ChiveArticle.last(20)
    buzzfeed_articles = BuzzfeedArticle.last(20)

    articles = chive_articles.concat(buzzfeed_articles).sort { |x,y| x.created_at <=> y.created_at }
    @articles = articles.paginate(:page => params[:page], :per_page => 20)
  end
end

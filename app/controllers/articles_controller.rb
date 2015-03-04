class ArticlesController < ApplicationController
  def index
    chive_articles = ChiveArticle.last(20)
    buzzfeed_articles = BuzzfeedArticle.last(20)
    memebase_articles = MemebaseArticle.last(20)
    r_funny_articles = RedditFunnyArticle.last(20)
    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles).concat(r_funny_articles)

    sorted_articles = articles.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @articles = sorted_articles.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @article = RedditFunnyArticle.friendly.find(params[:id])
  end
end

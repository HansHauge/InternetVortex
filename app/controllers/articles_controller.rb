class ArticlesController < ApplicationController
  def index
    time_range = (DateTime.current - 1.day)..DateTime.current

    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles)

    sorted_articles = articles.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @articles = sorted_articles.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @article = RedditFunnyPicture.friendly.find(params[:id])
  end

  def archive
    begin
      date = Time.parse(params[:date])
    rescue ArgumentError
      flash[:danger] = 'Invalid Date'
      redirect_to '/articles'
      return
    end

    time_range = date.at_beginning_of_day..date.at_end_of_day

    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)

    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles)

    sorted_articles = articles.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @articles = sorted_articles.paginate(:page => params[:page], :per_page => 30)
    @archive = true
    @channel = '/articles'

    flash.now[:danger] = 'No content found...' if @articles.count == 0
  end
end

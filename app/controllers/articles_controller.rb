class ArticlesController < ApplicationController
  before_action :set_archive_instance_variables, only: [:archive]

  def index
    time_range = (DateTime.current - 1.day)..DateTime.current
    sorted_articles = gather_sources(time_range)
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
    sorted_articles = gather_sources(time_range)
    @articles = sorted_articles.paginate(:page => params[:page], :per_page => 30)

    flash.now[:danger] = 'No content found...' if @articles.count == 0
  end

  private

  def set_archive_instance_variables
    @archive = true
    @channel = '/articles'
  end

  def gather_sources(time_range)
    sources = []
    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    cracked_articles = CrackedArticle.where(created_at: time_range)

    [chive_articles, buzzfeed_articles, memebase_articles, cracked_articles].each do |article|
      sources.concat(article)
    end

    sources.sort { |x,y| x.created_at <=> y.created_at }.reverse
  end
end

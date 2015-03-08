class WelcomeController < ApplicationController
  before_action :set_archive_instance_variables, only: [:archive]

  def home
    time_range = (DateTime.current - 1.day)..DateTime.current
    unsorted_listings = gather_sources(time_range)
    @listings = unsorted_listings.paginate(:page => params[:page], :per_page => 20)
  end

  def about
  end

  def archive
    begin
      date = Time.parse(params[:date])
    rescue ArgumentError
      flash[:danger] = 'Invalid Date'
      redirect_to '/'
      return
    end

    time_range = date.at_beginning_of_day..date.at_end_of_day
    unsorted_listings = gather_sources(time_range)
    @listings = unsorted_listings.paginate(:page => params[:page], :per_page => 20)

    flash.now[:danger] = 'No content found...' if @listings.count == 0
  end

  private

  def set_archive_instance_variables
    @archive = true
    @channel = ''
  end

  def gather_sources(time_range)
    unsorted_listings = []
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    r_funny_pictures = RedditFunnyPicture.where(created_at: time_range)
    jokes = Joke.where(created_at: time_range)
    videos = BreakVideo.where(created_at: time_range)

    [memebase_articles, r_funny_pictures, jokes, videos].each do |source|
      unsorted_listings.concat(source)
    end

    unsorted_listings.sort { |x,y| x.created_at <=> y.created_at }.reverse
  end
end

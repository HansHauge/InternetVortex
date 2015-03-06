class PicturesController < ApplicationController
  def index
    time_range = (DateTime.current - 1.day)..DateTime.current
    pictures = RedditFunnyPicture.where(created_at: time_range).sort { |x,y| x.created_at <=> y.created_at }.reverse
    @pictures = pictures.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @picture = RedditFunnyPicture.friendly.find(params[:id])
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
    r_funny_pictures = RedditFunnyPicture.where(created_at: time_range)

    pictures = r_funny_pictures.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @pictures = pictures.paginate(:page => params[:page], :per_page => 30)
    @archive = true
    @channel = '/pictures'

    flash.now[:danger] = 'No content found...' if @pictures.count == 0
  end
end

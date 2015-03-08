class PicturesController < ApplicationController
  before_action :set_archive_instance_variables, only: [:archive]

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
    @pictures = RedditFunnyPicture.where(created_at: time_range).paginate(:page => params[:page], :per_page => 30)
    flash.now[:danger] = 'No content found...' if @pictures.count == 0
  end

  private

  def set_archive_instance_variables
    @archive = true
    @channel = '/pictures'
  end
end

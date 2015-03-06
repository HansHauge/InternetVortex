class JokesController < ApplicationController

  def index
    time_range = (DateTime.current - 1.day)..DateTime.current

    jokes = Joke.where(created_at: time_range).sort { |x,y| x.created_at <=> y.created_at }.reverse
    @jokes = jokes.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @joke = Joke.friendly.find(params[:id])
  end

  def archive
    begin
      date = Time.parse(params[:date])
    rescue ArgumentError
      flash[:danger] = 'Invalid Date'
      redirect_to '/jokes'
      return
    end

    time_range = date.at_beginning_of_day..date.at_end_of_day

    @jokes = Joke.where(created_at: time_range).paginate(:page => params[:page], :per_page => 30)
    @archive = true
    @channel = '/jokes'

    flash.now[:danger] = 'No content found...' if @jokes.count == 0
  end
end

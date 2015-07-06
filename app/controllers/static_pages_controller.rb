class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_activities = current_user.feed.paginate page: params[:page],
                                                    per_page: Settings.paginate_per_page
    end
  end
  
  def about
  end
end

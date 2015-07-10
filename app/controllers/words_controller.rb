class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    if params[:filter_state]
      @words = Word.in_category(params[:category_id]).send(params[:filter_state], current_user)
        .paginate page: params[:page], per_page: Settings.paginate_per_page
    else
      @words = Word.paginate page: params[:page], per_page: Settings.paginate_per_page
    end
  end
end

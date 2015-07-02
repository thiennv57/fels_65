class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    @words = Word.in_category(params[:category_id]).paginate page: params[:page],
      per_page: Settings.paginate_per_page
  end
end

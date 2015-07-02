class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.paginate(page: params[:page], per_page: Settings.paginate_per_page).order :name
  end
end

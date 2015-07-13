class Admin::DashboardController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @users_length = User.count
    @categories_length = Category.count
    @words_length = Word.count
    @lessons_length = Lesson.count
  end
end

class Admin::DashboardController < ApplicationController
  def index
    @users_length = User.count
    @categories_length = Category.count
    @words_length = Word.count
    @lessons_length = Lesson.count
  end
end

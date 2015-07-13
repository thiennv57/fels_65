class LessonsController < ApplicationController
  before_action :set_category, only: [:show, :create, :update]
  before_action :set_lesson, only: [:show, :update]
  before_action :logged_in_user

  def create
    @words = @category.words.not_learned(current_user).random_questions
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      redirect_to category_lesson_path @category, @lesson
    else
      full_messages = ""
      @lesson.errors.full_messages.each do |message|
        full_messages += message
      end
      flash[:danger] = full_messages
      redirect_to category_path(@category)
    end
  end

  def show
    @time_remaining = @lesson.time_remaining
    @is_time_over = @time_remaining < 0
    @mark = @lesson.num_of_correct_ans if @is_time_over
  end

  def update
    if @lesson.update lesson_params
      respond_to do |format|
        format.html do
          flash[:success] = t("save_sucessfully").capitalize
          redirect_to category_lesson_path @category, @lesson
        end
        format.js
      end
    else
      flash[:danger] = t("submit_error").capitalize
      redirect_to categories_path
    end
  end

  private
  def set_category
    @category = Category.find params[:category_id]
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end
end

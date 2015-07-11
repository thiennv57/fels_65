class LessonsController < ApplicationController
  before_action :logged_in_user

  def index
    @lessons = Lesson.paginate page: params[:page], per_page: Settings.paginate_per_page
  end

  def new
    @category = Category.find params[:category_id]
    @words = @category.words.not_learned(current_user).random_words.limit(Settings.lesson.question_limit_words)
    if @words.count < Settings.lesson.category_minimum_words
      flash[:danger] = t "not_enough_word"
      redirect_to :back
    else
      @lesson = @category.lessons.build user: current_user
      @words.each do |word|
        result = @lesson.results.build
        result.word = word
      end
    end
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user_id = current_user.id
    if @lesson.save
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = t "submit_error"
      redirect_to :back
    end 
  end

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  private
  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end

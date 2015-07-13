class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  
  def index
    respond_to do |format|
      format.html do
        @categories = Category.name_ordered
        @word = Word.new
        Settings.answer.num_of_ans.times do 
          @answer = @word.answers.build
        end
      end
      format.csv {send_data export_csv}
    end
  end

  def create
    if @word = Word.find_by(word: params[:word][:word])
      @word.update_attributes word_params
      flash[:info] = t("update_successfully").capitalize
      redirect_to admin_words_path
    else
      @word = Word.new word_params
      if @word.save
        respond_to do |format|
          format.html do   
            flash[:info] = t("create_successfully").capitalize
            redirect_to admin_words_path
          end
          format.js
        end
      else
        @categories = Category.name_ordered
        Settings.answer.num_of_ans.times do 
          @answer = @word.answers.build
        end
        render :index
      end
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.html do   
        flash[:info] = t("delete_successfully").capitalize
        redirect_to admin_words_path
      end
      format.js
    end
  end

  private
  def set_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :word, :category_id, answers_attributes: [:id, :mean, :is_correct, :_destroy]
  end

  def export_csv
    headers = %w{category_name category_description word mean is_correct}
    CSV.generate(headers: true) do |csv|
      csv << headers
      Category.all.each do |category|
        category.words.each do |word|
          word.answers.each do |answer|
            csv << [category.name, category.description, word.word, answer.mean, answer.is_correct]
          end
        end
      end
    end
  end
end

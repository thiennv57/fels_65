class Admin::WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all
    @words = Word.all
    @word = Word.new
    Settings.answer.num_of_ans.times do 
      @answer = @word.answers.build
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
        @categories = Category.all
        @words = Word.all
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
end

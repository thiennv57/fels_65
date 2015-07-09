class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit   
  end

  def update 
    if @category.update category_params
      flash[:success] = t("update_successfully").capitalize
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.html do   
          flash[:info] = t("create_successfully").capitalize
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html do   
        flash[:info] = t("delete_successfully").capitalize
        redirect_to admin_categories_path
      end
      format.js
    end
  end

  private
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end

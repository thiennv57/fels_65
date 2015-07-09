class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate page: params[:id], per_page: Settings.paginate_per_page
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        flash[:success] = t("delete_successfully").capitalize
        redirect_to admin_users_path
      end
      format.json {head :no_content}
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end

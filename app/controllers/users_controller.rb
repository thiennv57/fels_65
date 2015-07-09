class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:show, :create, :new]
  before_action :correct_user, only: [:edit, :update]
 
  def index
    @users = User.paginate page: params[:id],
                           per_page: Settings.paginate_per_page
  end

  def new
    @user = User.new
  end

  def show
    @activities = @user.activities.recent.paginate page: params[:page],
                                                   per_page: Settings.paginate_per_page
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "check_email_request_message"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:info] = t "update_account_successfully"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :avatar, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_log_in"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end
end

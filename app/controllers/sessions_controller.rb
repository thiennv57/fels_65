class SessionsController < ApplicationController
  def new
    redirect_to request.headers["Referer"] ||= root_path if current_user
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.remember_me_check ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash.now[:danger] = t "invalid_email_password"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

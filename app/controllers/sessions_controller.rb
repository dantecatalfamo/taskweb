class SessionsController < ApplicationController
  def create
    Rails.logger.info("Attempting to login as #{session_params[:username]}")
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      Rails.logger.info("Successful login as #{session_params[:username]}")
      reset_session
      session[:user_id] = @user.id
      flash[:notice] = 'logged in'
      redirect_to home_path
    else
      Rails.logger.info("Failed login as #{session_params[:username]}")
      flash.now[:alert] = 'Incorrect email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def new; end

  def destroy
    Rails.logger.info("Logout from #{current_user.username}")
    reset_session
    redirect_to home_path, notice: 'Signed out'
  end

  private

  def session_params
    params.require(:login).permit(:username, :password)
  end
end

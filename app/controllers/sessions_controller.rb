class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if @user&.authenticate(session_params[:password])
      reset_session
      session[:user_id] = @user.id
      flash[:notice] = 'logged in'
      redirect_to home_path
    else
      flash.now[:alert] = 'Incorrect email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def new; end

  def destroy
    reset_session
    redirect_to home_path, notice: 'Signed out'
  end

  private

  def session_params
    params.require(:login).permit(:username, :password)
  end
end

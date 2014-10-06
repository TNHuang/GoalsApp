class SessionsController < ApplicationController
  before_action :require_no_user, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user.nil?
      flash.now[:errors] = ["Invalid username or password"]
      @user = User.new(username: params[:user][:username])
      render :new
    else
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end

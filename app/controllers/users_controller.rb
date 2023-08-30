class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save!
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def new
    @user = User.new
  end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_type)
  end
end

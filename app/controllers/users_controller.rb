class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]


  def index
  	@users = User.all
  	@new_book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@new_book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      #flash[:notice] = "error"
      render action: :edit
    end
  end

  private
  def user_params
	  params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def ensure_correct_user
    if current_user != User.find(params[:id])
      redirect_to user_path(current_user.id)
    end
  end
end

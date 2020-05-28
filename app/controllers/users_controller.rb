class UsersController < ApplicationController
   before_action :authenticate_user!, :only => [:show, :index, :edit]

	def top
	end

  def about
  end


  def index
  	@user = User.all
  	@book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books.all
  end


  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updatetad successfully.'
    else
      render action: :edit
    end
  end

private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

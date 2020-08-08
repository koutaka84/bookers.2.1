class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :eroos, only: [:edit,:update]
	def edit
		@user = User.find(params[:id])
	end
	def show
		@user = User.find(params[:id])
		@newBook = Book.new
		@books = @user.books
	end

	def index
		@users = User.all
       @user = current_user
       @newBook = Book.new
	end

	def update
		@user = User.find(params[:id])
	  
	  if @user.update(user_params)
	  	flash[:notice]="You have updated user successfully."
	  	redirect_to user_path(@user.id)
	  else
		render :edit
	  end
	end

	private
	def eroos
    user = User.find(params[:id])
    if  (current_user.id !=  user.id)
      redirect_to user_path(current_user.id)
    end
end
	def user_params
	params.require(:user).permit(:name, :profile_image, :introduction)
    end
end

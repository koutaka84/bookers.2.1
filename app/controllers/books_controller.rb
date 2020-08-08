class BooksController < ApplicationController
before_action :authenticate_user!
before_action :eroos, only: [:edit,:update]
	def index
		@book = Book.new
		@user = current_user
		@books = Book.all
	end

	def destroy
		@book = Book.find(params[:id])
	    @book.destroy
	    redirect_to books_path
	end

	def new
		@books = Book.new
		@user = current_user
    end

	def create
		@book  = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id),notice: "You have creatad book successfully."
		else
			@books = Book.all
			@user = current_user
			render :index
		end
	end

	def edit
		@book = Book.find(params[:id])
		@books = Book.all
	end
	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		redirect_to book_path(@book.id),notice: "You have updated book successfully."
		else
			render :edit
     end
	end
	def show
		@book = Book.find(params[:id])
		@newbook = Book.new

	end
	private
  # ストロングパラメータ
  def eroos
    book = Book.find(params[:id])
    user = current_user
    if user.id != (book.user_id).to_i
      redirect_to books_path
    end
 end

 def book_params
    params.require(:book).permit(:title, :body,:user_id)
  end
end
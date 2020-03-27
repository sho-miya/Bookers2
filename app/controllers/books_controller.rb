class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_book, only: [:edit]

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		  flash[:notice] = "You have creatad book successfully."
		  redirect_to book_path(@book.id)
		else
		  flash[:notice] = "error"
		  @books = Book.all
		  redirect_to books_path
		end
	end

	def index
		@new_book = Book.new
		@books = Book.all
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		  flash[:notice] = "You have updated book successfully."
		  redirect_to book_path(@book.id)
		else
		  #flash[:notice] = "error"
		  @books = Book.all
		  #@user = current_user
		  render action: :edit
		end
	end

	def show
		@new_book = Book.new
		@book = Book.find(params[:id])
		@user = @book.user
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end

	def ensure_correct_book
	  @book = Book.find(params[:id])
      if current_user != @book.user
        redirect_to books_path
      end
    end
end

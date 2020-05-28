class BooksController < ApplicationController
 before_action :authenticate_user!, :only => [:show, :index, :edit]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
  	@book1 = Book.new
  	@book2 = Book.find(params[:id])
  	@user = User.find(@book2.user_id)
  end

  def new
  	@book = Book.new
  end

  def create
    logger.debug("[start] book create")
  	book = Book.new(book_params)
  	book.user_id = current_user.id
    if book.save
  	  redirect_to book_path(book.id), notice: 'You have creatad book successfully.'
    else
      @book = book
      @books = Book.all
      render action: :index
    end
  end


  def edit
  	@book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
  	book = Book.find(params[:id])
  	book.user_id = current_user.id
  	if book.update(book_params)
  	   redirect_to book_path(book.id), notice: 'You have updatetad book successfully.'
    else
      @book = book
      render action: :edit
    end
  end

  def destroy
  	book = Book.find(params[:id])
	book.destroy
  	redirect_to books_path, notice: 'You have deletetad book successfully.'
  end

 private
def book_params
	params.require(:book).permit(:title, :body, :user_id)
end

end

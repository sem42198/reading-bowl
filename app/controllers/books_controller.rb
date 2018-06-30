class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def manage
    check_admin_permission
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    check_admin_permission
  end

  def create
    return unless check_admin_permission
    @book = Book.new(book_params)

    if @book.save
      redirect_to "/books/show/#{@book.id}"
    else
      render :new
    end
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end
end

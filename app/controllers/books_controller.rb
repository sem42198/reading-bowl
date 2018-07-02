class BooksController < ApplicationController

  before_action :validate_admin, only: [:manage, :new, :create]

  def index
    @books = Book.all
  end

  def manage
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
  end

  def create
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

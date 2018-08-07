class BooksController < ApplicationController

  before_action :validate_admin, only: [:new, :create]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to "/books/#{@book.id}/show"
    else
      render :new
    end
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end
end

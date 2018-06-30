class QuestionsController < ApplicationController
  def show
  end

  def new
  end

  def create
    book = Book.find(book_id_param)
    cookies[:book_id] = book.id
    render :new if book.update(question_params)
  end

  def index
  end

  def practice
  end

  def book_id_param
    params.require(:book).permit(:book_id)[:book_id]
  end

  def question_params
    params.require(:book).permit(:questions_attributes => [:user_id, :question, :answer])
  end

  def practice_params

  end

end

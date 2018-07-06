class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @book = @question.book
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
    data = practice_data
    books = data[:books]
    books.delete('')
    unless !books || books.empty?
      session[:practice_books] = books
      session[:starred_only] = data[:starred_only]
      session[:question_queue] = {}
      next_question
    end
  end

  def next_question
    book = Book.find(session[:practice_books].sample)
    question_queue = session[:question_queue][book.id]
    build_question_queue(book) unless question_queue && !question_queue.empty?
    question_queue = session[:question_queue][book.id]
    question_id = question_queue.pop
    if question_id
      redirect_to "/questions/show/#{question_id}"
    else
      next_question
    end
  end

  def build_question_queue(book)
    queue = book.questions.collect {|q| q.id}.shuffle
    session[:question_queue][book.id] = queue
  end

  def book_id_param
    params.require(:book).permit(:book_id)[:book_id]
  end

  def question_params
    params.require(:book).permit(:questions_attributes => [:user_id, :question, :answer])
  end

  def practice_data
    params.require(:practice_data).permit(:starred_only, :books => [])
  end

end

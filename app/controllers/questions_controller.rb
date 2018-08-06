class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @book = @question.book
  end

  def new; end

  def create
    book = Book.find(book_id_param)
    cookies[:book_id] = book.id
    render :new if book.update(questions_params)
  end

  def index; end

  def practice
    data = practice_data
    books = data[:books]
    books.delete('')
    books ||= []
    session[:practice_books] = books
    session[:question_queue] = {}
    session[:starred_only] = data[:starred_only] || false

    next_question

  end

  def next_question

    if session[:practice_books].empty?
      flash[:danger] = 'No questions found.'
      return redirect_to '/questions/practice'
    end

    book = Book.find(session[:practice_books].sample)
    question_queue = session[:question_queue][book.id.to_s]

    unless question_queue && !question_queue.empty?
      build_question_queue(book)
      question_queue = session[:question_queue][book.id]
    end

    question_id = question_queue.pop

    if question_id
      redirect_to "/questions/#{question_id}/show"
    else
      next_question
    end
  end

  def edit
    @question = Question.find(params[:id])
    @book = @question.book
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = 'Question updated.'
      redirect_to "/questions/#{params[:id]}/show"
    else
      flash[:danger] = 'Could not update question.'
      redirect_to "/questions/#{params[:id]}/edit"
    end
  end

  def star_toggle
    @question = Question.find(params[:id])
    @question.starred = !@question.starred
    flash[:danger] = 'Error saving.' unless @question.save
    puts 'Called toggle star!'
  end

  private

  def build_question_queue(book)
    queue = if session[:starred_only] == '1'
              book.questions.where(starred: true).collect(&:id).shuffle
            else
              book.questions.collect(&:id).shuffle
            end
    session[:practice_books].delete(book.id.to_s) if queue.empty?
    session[:question_queue][book.id] = queue
    !queue.empty?
  end

  def book_id_param
    params.require(:book).permit(:book_id)[:book_id]
  end

  def questions_params
    params.require(:book).permit(questions_attributes: %i[user_id question answer])
  end

  def question_params
    params.require(:question).permit(:book_id, :question, :answer)
  end

  def practice_data
    params.require(:practice_data).permit(:starred_only, books: [])
  end
end

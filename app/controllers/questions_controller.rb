# frozen_string_literal: true

class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @book = @question.book
  end

  def new
    @book = Book.new
  end

  def create
    id = params[:book][:book_id]
    book = Book.find(id)
    cookies[:book_id] = id
    if book.update(questions_params)
      flash[:success] = 'Question(s) saved'
      @book = Book.new
    else
      flash[:danger] = book.errors.full_messages.join ', '
      @book = Book.new questions_params
    end
    render :new
  end

  def index; end

  def practice
    data = practice_data
    books = data[:books]
    books.delete('')
    books ||= []
    session[:practice_books] = books
    session[:starred_only] = data[:starred_only] || false
    user.clear_question_queue

    next_question
  end

  def next_question
    if session[:practice_books].nil? || session[:practice_books].empty?
      flash[:danger] = 'No questions founAttendance.where(:user_id => @user.id)d.'
      return redirect_to '/questions/practice'
    end

    book = Book.find(session[:practice_books].sample)
    question_queue = user.question_queue[book.id.to_s]

    unless question_queue && !question_queue.empty?
      unless user.build_question_queue(book, session[:starred_only] == '1')
        session[:practice_books].delete(book.id.to_s)
      end
    end

    question_id = user.pop_question(book.id)

    if question_id
      redirect_to "/questions/#{question_id}/show"
    else
      next_question
    end
  end

  def edit
    session[:return_to] ||= request.referer
    @question = Question.find(params[:id])
    @book = @question.book
  end

  def delete
    @question = Question.find(params[:id])
    book = @question.book
    @question.delete
    redirect_back(fallback_location: "/books/#{book.id}/show")
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = 'Question updated.'
      redirect_to session.delete(:return_to)
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

  def questions_params
    params.require(:book).permit(questions_attributes: %i[user_id question answer page])
  end

  def question_params
    params.require(:question).permit(:book_id, :question, :answer, :page, :starred)
  end

  def practice_data
    params.require(:practice_data).permit(:starred_only, books: [])
  end
end

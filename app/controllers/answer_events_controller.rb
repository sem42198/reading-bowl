class AnswerEventsController < ApplicationController

  before_action :validate_admin, :only => [:create]

  def create
    user_id = params[:user_id]
    question_id = params[:question_id]
    answer = AnswerEvent.new
    answer.user_id = user_id
    answer.question_id = question_id
    answer.save
  end
end

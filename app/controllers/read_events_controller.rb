class ReadEventsController < ApplicationController

  before_action :validate_admin, :only => [:create]

  def create
    user_id = params[:user_id]
    book_id = params[:book_id]
    read_event = ReadEvent.new
    read_event.user_id = user_id
    read_event.book_id = book_id
    read_event.save
  end
end

class AttendanceController < ApplicationController

  before_action :validate_admin, :only => [:create]

  def create
    attendance = Attendance.new
    attendance.user_id = params[:user_id]
    attendance.save
  end

  def show
    @user = User.find(params[:user_id])
    @attendances = Attendance.where(:user_id => @user.id)
  end
end

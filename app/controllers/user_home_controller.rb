class UserHomeController < ApplicationController

  def new
    @user = user

    if @user.present?

      if @user.instructor?
        render :instructor_home
        else
        render :student_home
      end
    else
      redirect_to '/'
    end
  end

  def instructor_home

  end

  def student_home

  end
end

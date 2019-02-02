class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :validate_user

  include ApplicationHelper

  def validate_user
    render 'layouts/permission_denied' unless user
  end

  def validate_admin
    is_admin = user&.instructor?
    render 'layouts/permission_denied' unless is_admin
    is_admin
  end

  def errors_for(record)
    record.errors.full_messages.join ', '
  end
end

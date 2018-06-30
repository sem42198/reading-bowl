class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  def check_admin_permission
    is_admin = user&.instructor?
    render 'layouts/permission_denied' unless is_admin
    is_admin
  end
end

module ApplicationHelper

  def user
    id = session[:user_id]
    id.present? ? User.find(id) : nil
  end

end

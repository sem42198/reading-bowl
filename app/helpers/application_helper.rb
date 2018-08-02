module ApplicationHelper

  def user
    id = session[:user_id]
    id.present? ? User.find(id) : nil
  end

  # icons should be in the format [id, text, image], [id, text], [id], or id
  def icon_group(id, icons, image_default = nil)
    icons.each do |icon|
      icon = [icon] unless icon.is_a? Array
      raise if icon.empty?
      icon.push(nil) if icon.size == 1
      icon.push(nil) if icon.size == 2
      icon[1] ||= icon[0]
      icon[2] ||= image_default
    end
    render :partial => 'layouts/icon_group', :locals => {:id => id, :icons => icons}
  end
end

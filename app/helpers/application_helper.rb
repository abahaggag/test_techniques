module ApplicationHelper
  
  def search_container_for(title, search_form)
    render partial: 'application/search_container', locals: {title: title, search_form: search_form}
  end
  
  def error_messages_for(object)
    render partial: 'application/error_messages', locals: {object: object}
  end
  
end

module DeviseHelper
  def devise_error_messages!(another_resourse = nil)
    error_handler = another_resourse || resource
    return '' if error_handler.errors.empty?
    messages = error_handler.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="text-center alert alert-error alert-danger">
       <button type="button" class="close" data-dismiss="alert">×</button>
       #{messages}
    </div>
    HTML
    html.html_safe
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
module ApplicationHelper

  def render_error(instance)
    return '' if instance.errors.empty?
    messages = instance.errors.full_messages.uniq.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="text-center alert alert-error alert-danger">
       <button type="button" class="close" data-dismiss="alert">×</button>
       #{messages}
    </div>
    HTML
    html.html_safe
  end

  def active_categories
    Category.active
  end

  def empty_cart?
    current_user_or_guest ? current_user_or_guest.orders.empty? : true
  end

  def last_order
    current_user.orders.
        where.not(aasm_state: :canceled)
        .order('updated_at DESC')
        .first
  end

  def purchases_count
    current_order.order_items.count unless current_order.nil?
  end
end

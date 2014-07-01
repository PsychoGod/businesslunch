module ApplicationHelper
  def navbar_link_to(title, path, icon = '', prefix = true)
    content_tag :li, class: ('active' if current_page?(path)) do
      link_to(iconized_text(title, icon, prefix).html_safe, path)
    end
  end

  def iconized_text(text, icon, prefix = true)
    prefix ? "#{glyphicon(icon)} #{text}" : "#{text} #{glyphicon(icon)}"
  end

  def glyphicon(name)
    if name
      content_tag :i, '', class: "glyphicon glyphicon-#{name}"
    else
      ''
    end
  end

  def can_remove_order?(order)
    can?(:manage, order) && !Freeze.frozen? && order.created_on > Date.yesterday
  end

  def link_to_delete(object)
    link_to object, method: :delete, data: { confirm: t(:are_you_sure) }, class: 'btn btn-danger btn-sm', id: dom_id(object, :delete) do
      content_tag :i, '', class: 'glyphicon glyphicon-trash'
    end
  end
end

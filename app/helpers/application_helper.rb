# coding: utf-8

module ApplicationHelper
  def full_title(page_title)
    base_title = "宇哲"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
  
  def info_name(info = "infos")
    case
    when info == items_path
      "条目"
    when info == users_path
      "用户"
    else
      "信息"
    end
  end

  def parent_params
    {parent_type:params[:parent_type].singularize.capitalize, parent_id:params[:parent_id]}
  end

  def parent_url(action)
    {action:action, parent_type:params[:parent_type], parent_id:params[:parent_id]}
  end

  def truncate(content)
    content.truncate(100, separator: ' ')
  end
end

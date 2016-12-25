module ContentsHelper
  def new_url(parent_type, parent_id, child_type)
    content_url(parent_type:parent_type.pluralize.downcase, parent_id:parent_id,
                controller: child_type.pluralize.downcase, action: "new")
  end
end
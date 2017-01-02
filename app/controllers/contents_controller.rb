class ContentsController < ApplicationController
  def destroy
      content = Content.find(params[:id])
      parent = content.parent
      if content.destroy
          redirect_to view_context.content_entity_url(parent)
      end
  end
end

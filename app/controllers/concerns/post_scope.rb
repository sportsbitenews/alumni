module PostScope
  extend ActiveSupport::Concern

  def set_post
    fail UnauthorizedPostTypeException unless Post::POST_TYPES.include?(params[:type])
    @post = params[:type].constantize.find(params[:post_id] || params[:id])
    authorize @post
  end
end

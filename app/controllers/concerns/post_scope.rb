module PostScope
  extend ActiveSupport::Concern

  def set_post
    set_post_without_authorize
    authorize @post
  end

  def set_post_without_authorize
    fail UnauthorizedPostTypeException unless Post::POST_TYPES.include?(params[:type])
    @post = post_type.find(params[:post_id] || params[:id])
  end

  def post_type
    params[:type].constantize
  end
end

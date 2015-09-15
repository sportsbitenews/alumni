module PostScope
  extend ActiveSupport::Concern

  def set_post
    set_post_without_authorize
    authorize @post
  end

  def set_post_without_authorize
    fail UnauthorizedPostTypeException unless Post::POST_TYPES.include?(params[:type])
    @post = params[:type].constantize.find(params[:post_id] || params[:id])
  end
end

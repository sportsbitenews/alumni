class Api::V1::TestimonialsController < Api::V1::BaseController
  def index
    Testimonial.find params[:locale]
    raise
  end
end

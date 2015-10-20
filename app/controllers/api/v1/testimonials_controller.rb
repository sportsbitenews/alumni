class Api::V1::TestimonialsController < Api::V1::BaseController
  def index
    @testimonials = Testimonial.where locale: params[:locale]
  end
end

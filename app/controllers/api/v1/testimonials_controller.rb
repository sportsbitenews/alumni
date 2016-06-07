class Api::V1::TestimonialsController < Api::V1::BaseController
  def index
    @testimonials = Testimonial.where locale: params[:locale]
    if params[:slug]
      @testimonials.to_a.select!{ |testimonial| testimonial.user.batch.city.slug == params[:slug] }
    end
  end
end

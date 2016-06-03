class Api::V1::TestimonialsController < Api::V1::BaseController
  def index
    @testimonials = Testimonial.where locale: params[:locale]
    if params[:city]
      @testimonials.to_a.select!{ |testimonial| testimonial.user.batch.city.name.downcase == params[:city] }
    end
  end
end

class TestimonialsController < ApplicationController
  before_action :set_city

  def create
    github_nickname = params[:github_nickname]
    user = User.find_by_slug(github_nickname)
    testimonial = Testimonial.new(content: params[:content], locale: params[:locale])
    testimonial.user = user
    authorize testimonial
    if !testimonial.save
      @error_content = testimonial.errors.full_messages.join(", ")
    end
    set_testimonials
  end

  def update
    github_nickname = params[:github_nickname]
    user = User.find_by_slug(github_nickname)
    testimonial = Testimonial.find(params[:id])
    authorize testimonial
    testimonial.user = user
    if !testimonial.update(content: params[:content], locale: params[:locale])
      @error_content = testimonial.errors.full_messages.join(", ")
    end
    set_testimonials
  end

  private

  def set_city
    @city = City.find_by_slug(params[:city_slug])
  end

  def set_testimonials
    @testimonials = Testimonial.includes(user: { batch: :city }).where(cities: { slug: params[:city_slug]})
  end
end

class TestimonialsController < ApplicationController
  def create
    @city = City.find_by_slug(params[:city_slug])
    @github_nickname = params[:github_nickname]
    @user = User.find_by_slug(@github_nickname)
    if @user
      testimonial = Testimonial.new(content: params[:content], locale: params[:locale])
      testimonial.user = @user
      authorize testimonial
      testimonial.save
    end
    @testimonials = Testimonial.includes(user: { batch: :city }).where(cities: { slug: params[:city_slug]})
    authorize @testimonials, :create?
  end

  def update
    @city = City.find_by_slug(params[:city_slug])
    @github_nickname = params[:github_nickname]
    @user = User.find_by_slug(@github_nickname)
    if @user
      testimonial = Testimonial.find(params[:id])
      authorize testimonial
      testimonial.update(content: params[:content], locale: params[:locale], user_id: @user.id)
    end
    @testimonials = Testimonial.includes(user: { batch: :city }).where(cities: { slug: params[:city_slug]})
    authorize @testimonials, :update?
  end
end

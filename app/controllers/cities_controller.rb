class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :set_manager]

  def index
    @cities = policy_scope(City).order(name: :asc)
    if @cities.blank?
      flash[:alert] = "Sorry, you do not manage any city"
      redirect_to root_path
    elsif @cities.size == 1
      redirect_to city_path(@cities.first)
    end
  end

  def show
    @managers = User.joins(:cities).where(cities: { slug: @city.slug})
  end

  def edit
    @testimonials = Testimonial.includes(user: { batch: :city }).where(cities: { slug: @city.slug})
    @teacher_ordered_list = OrderedList.find_or_create_by!(name: "#{params[:id]}_teachers", element_type: 'User')
    @teaching_assistant_ordered_list = OrderedList.find_or_create_by!(name: "#{params[:id]}_teacher_assistants", element_type: 'User')
    @teachers = User.where(github_nickname: @teacher_ordered_list.slugs).sort_by {|t| @teacher_ordered_list.slugs.index(t.github_nickname) }
    @teaching_assistants = User.where(github_nickname: @teaching_assistant_ordered_list.slugs).sort_by {|t| @teaching_assistant_ordered_list.slugs.index(t.github_nickname) }
  end

  def update
    if @city.update(city_params)
      redirect_to city_path(@city)
    else
      render :edit
    end
  end

  def markdown_preview
    @content = params[:content]
    authorize(City)
  end

  def set_manager
    @github_nickname = params[:github_nickname]
    @user = User.find_by_slug(@github_nickname)
    if @user
      if params[:remove]
        @user.cities.delete(@city)
      else
        @user.cities << @city
      end
    end
    @managers = User.joins(:cities).where(cities: { slug: @city.slug })
  end

  private

  def set_city
    @city = City.friendly.find(params[:id])
    authorize @city
  end

  def city_params
    params.require(:city).permit(:logistic_specifics, :marketing_specifics)
  end
end

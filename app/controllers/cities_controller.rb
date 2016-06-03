class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :set_manager]

  def index
    @cities = policy_scope(City)
  end

  def show
    @managers = User.joins(:cities).where(cities: { slug: @city.slug})
  end

  def edit
    teachers = OrderedList.find_by_name "#{params[:id]}_teachers"
    teacher_assistants = OrderedList.find_by_name "#{params[:id]}_teacher_assistants"
    @teachers = User.where(github_nickname: teachers.slugs).sort_by {|t| teachers.slugs.index(t.github_nickname) }
    @teacher_assistants = User.where(github_nickname: teacher_assistants.slugs).sort_by {|t| teacher_assistants.slugs.index(t.github_nickname) }
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
    if params[:remove]
      @user.cities.delete(@city)
    else
      if @user
        @user.cities << @city
      end
    end
    @managers = User.joins(:cities).where(cities: { slug: @city.slug})
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

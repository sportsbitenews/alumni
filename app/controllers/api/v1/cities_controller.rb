class Api::V1::CitiesController < Api::V1::BaseController
  def index
    @city_ordered_list = OrderedList.find_by_name('official_cities')
    if @city_ordered_list
      @cities = City.where(slug: @city_ordered_list.slugs).sort_by do |city|
        @city_ordered_list.slugs.index(city.slug)
      end
    else
      @cities = City.all
    end
    @meetup_client = MeetupApi.new
  end

  def show
    @city = City.friendly.find(params[:id])
    teachers = OrderedList.find_by_name "#{params[:id]}_teachers"
    teacher_assistants = OrderedList.find_by_name "#{params[:id]}_teacher_assistants"
    if teachers
      @teachers = User.where(github_nickname: teachers.slugs).sort_by {|t| teachers.slugs.index(t.github_nickname) }
    else
      @teachers = @city.teachers.select(&:teacher)
    end
    if teacher_assistants
      @teacher_assistants = User.where(github_nickname: teacher_assistants.slugs).sort_by {|t| teacher_assistants.slugs.index(t.github_nickname) }
    else
      @teacher_assistants = @city.teachers.select(&:teacher_assistant)
    end
  end
end

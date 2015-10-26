class Api::V1::StaffController < Api::V1::BaseController
  def index
    if params[:city].present?
      city = City.friendly.find(params[:city])
      teachers = OrderedList.find_by_name "#{params[:city]}_teachers"
      teacher_assistants = OrderedList.find_by_name "#{params[:city]}_teacher_assistants"
      if teachers
        @teachers = User.where(github_nickname: teachers.slugs).sort_by {|t| teachers.slugs.index(t.github_nickname) }
      else
        @teachers = city.teachers.select(&:teacher)
      end
      if teacher_assistants
        @teacher_assistants = User.where(github_nickname: teacher_assistants.slugs).sort_by {|t| teacher_assistants.slugs.index(t.github_nickname) }
      else
        @teacher_assistants = city.teachers.select(&:teacher_assistant)
      end
    else
      @teachers = User.where(teacher: true)
      @teacher_assistants = User.where(teacher_assistant: true)
    end
  end
end

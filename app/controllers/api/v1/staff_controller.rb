class Api::V1::StaffController < Api::V1::BaseController
  def index
    if params[:city].present?
      city = City.friendly.find(params[:city])
      @teachers = city.teachers.select(&:teacher)
      @teacher_assistants = city.teachers.select(&:teacher_assistant)
    else
      @teachers = User.where(teacher: true)
      @teacher_assistants = User.where(teacher_assistant: true)
    end
  end
end

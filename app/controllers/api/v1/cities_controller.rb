class Api::V1::CitiesController < Api::V1::BaseController
  def index
    @cities = params[:active].present? ? City.where(active: true) : City.all
  end
  def show
    @city = City.friendly.find(params[:id])
    @teachers = @city.teachers.select(&:teacher)
    @teacher_assistants = @city.teachers.select(&:teacher_assistant)
  end
end

class Api::V1::CitiesController < Api::V1::BaseController
  def index
    @cities = params[:active].present? ? City.where(active: true) : City.all
  end
  def show
    @city = City.friendly.find(params[:id])
    @teachers = @city.next_available_batch.teachers.select(&:teacher)
    @teacher_assistants = @city.next_available_batch.teachers.select(&:teacher_assistant)
  end
end

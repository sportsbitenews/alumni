class BatchesController < ApplicationController
  before_action :set_batch, only: %i(show edit update register)
  before_action :set_city, only: %i(new create)
  skip_before_action :authenticate_user!, only: %i(show onboarding register)

  def show
  end

  def new
    next_monday = Date.today + ((1 - Dat.today.wday) % 7)
    @batch = @city.batches.build(starts_at: next_monday)
    authorize @batch
  end

  def create
    @batch = @city.batches.build(batch_params)
    authorize @batch
    if @batch.save
      redirect_to @batch.city
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @batch.update(batch_params)
      redirect_to @batch.city
    else
      render :edit
    end
  end

  def onboarding
    @batches = Batch.where(onboarding: true)
    authorize @batches
  end

  def register
    @user = current_user
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
    authorize @batch
  end

  def set_city
    @city = City.find(params[:city_id])
  end

  def batch_params
    params.require(:batch).permit(:name, :starts_at)
  end
end

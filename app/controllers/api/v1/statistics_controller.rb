class Api::V1::StatisticsController < Api::V1::BaseController
  def show
    @alumni_count = Batch.completed_or_in_progress.map(&:user_count).reduce(:+)
    @alumni_cities = per_cities { |city| city.batches.completed_or_in_progress.map(&:user_count).reduce(:+) || 0 }

    @batches_count = Batch.completed_or_in_progress.count
    @batches_cities = per_cities { |city| city.batches.completed_or_in_progress.count }
  end

  private

  def per_cities(&block)
    City.all.reduce(Hash.new) do |h, city|
      h[city.slug] = block.call(city)
      h
    end
  end
end

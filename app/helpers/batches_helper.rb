module BatchesHelper
  def batch_period(batch)
    start_date = batch.starts_at
    end_date = batch.ends_at
    if start_date.year == end_date.year
      return "#{l(start_date, format: '%b')}-#{l(end_date, format: '%b')} #{start_date.year}"
    else
     return "#{l(start_date, format: '%b %Y')} - #{l(end_date, format: '%b %Y')}"
   end
  end
end

module Cacheable
  extend ActiveSupport::Concern

  included do
    after_save ->() { InvalidateWwwCacheJob.perform_later }
  end
end

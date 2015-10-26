# == Schema Information
#
# Table name: ordered_lists
#
#  id           :integer          not null, primary key
#  name         :string
#  element_type :string
#  slugs        :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class OrderedList < ActiveRecord::Base
  ELEMENT_TYPES = %w(User Project City)
  validates :element_type, inclusion: { in: ELEMENT_TYPES }
  validate :slugs_exist?

  after_save ->() { InvalidateWwwCacheJob.perform_later }

  rails_admin do
    edit do
      field :element_type, :enum do
        enum do
           ELEMENT_TYPES
        end
      end
      field :name, :string
      field :slugs, :pg_string_array
    end
  end

  def slugs_exist?
    slugs.each do |slug|
      if !element_type.constantize.find_by_slug(slug)
        errors.add :slugs, "#{slug} is not an existing #{element_type}"
      end
    end
  end
end

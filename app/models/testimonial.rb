# == Schema Information
#
# Table name: testimonials
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :string
#  locale     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_testimonials_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_4d3e46b658  (user_id => users.id)
#

class Testimonial < ActiveRecord::Base
  include Cacheable
  belongs_to :user
  validates :user, presence: { message: "'s GitHub nickname is not authorized." }
  validates :content, presence: true
  validates :locale, presence: true
end

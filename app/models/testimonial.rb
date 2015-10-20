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

class Testimonial < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :content, presence: true
  validates :locale, presence: true
end

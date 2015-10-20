# == Schema Information
#
# Table name: testimonials
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  en         :string
#  fr         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_testimonials_on_user_id  (user_id)
#

class Testimonial < ActiveRecord::Base
  belongs_to :user
  validates :en, presence: true
  validates :fr, presence: true
end

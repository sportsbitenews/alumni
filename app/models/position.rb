# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_positions_on_company_id  (company_id)
#  index_positions_on_user_id     (user_id)
#

class Position < ActiveRecord::Base
  include Cacheable
  validates :title, :user, :company, presence: true
  belongs_to :user
  belongs_to :company
end

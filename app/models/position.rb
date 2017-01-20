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
# Foreign Keys
#
#  fk_rails_4e4581e38b  (user_id => users.id)
#  fk_rails_9d634cdbb9  (company_id => companies.id)
#

class Position < ActiveRecord::Base
  include Cacheable
  validates :title, :user, :company, presence: true
  belongs_to :user, inverse_of: :positions
  belongs_to :company
end

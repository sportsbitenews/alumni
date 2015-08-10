# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  company       :string
#  position      :string
#  ad_url        :string
#  contact_email :string
#  city          :string
#  remote        :boolean
#  type          :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ActiveRecord::Base
end

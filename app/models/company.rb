# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  url               :string
#

class Company < ActiveRecord::Base
  validates :name, presence: true
  has_many :stories

  has_attached_file :logo,
    styles: { thumbnail: { geometry: "270x180>", format: 'png' } }
  validates_attachment_content_type :logo,
    content_type: /\Aimage\/.*\z/

end

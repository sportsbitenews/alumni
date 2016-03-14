# == Schema Information
#
# Table name: stories
#
#  id                   :integer          not null, primary key
#  description_en       :text
#  description_fr       :text
#  published            :boolean          default(FALSE), not null
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  company_id           :integer
#  title_en             :string
#  title_fr             :string
#  summary_fr           :text
#  summary_en           :text
#  slug                 :string
#
# Indexes
#
#  index_stories_on_company_id  (company_id)
#  index_stories_on_slug        (slug) UNIQUE
#  index_stories_on_user_id     (user_id)
#

class Story < ActiveRecord::Base
  include Cacheable

  validates :description_en, :description_fr, :user, :picture, presence: true
  validates :slug, presence: true, uniqueness: true
  belongs_to :user
  has_attached_file :picture,
    styles: { cover: { geometry: "1400x787>", format: 'jpg', quality: 40 },  thumbnail: { geometry: "270x180>", format: 'jpg', quality: 20 } }, processors: [ :thumbnail, :paperclip_optimizer ]
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
  belongs_to :company

end

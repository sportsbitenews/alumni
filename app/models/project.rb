# == Schema Information
#
# Table name: projects
#
#  id                         :integer          not null, primary key
#  name                       :string
#  url                        :string
#  batch_id                   :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  tagline_en                 :string
#  cover_picture_file_name    :string
#  cover_picture_content_type :string
#  cover_picture_file_size    :integer
#  cover_picture_updated_at   :datetime
#  position                   :integer
#  slug                       :string
#  tagline_fr                 :string
#
# Indexes
#
#  index_projects_on_batch_id  (batch_id)
#

class Project < ActiveRecord::Base
  include Cacheable
  belongs_to :batch
  has_many :milestones
  has_and_belongs_to_many :users
  acts_as_list scope: :batch
  has_attached_file :cover_picture,
    styles: { cover: { geometry: "1400x730>", format: 'jpg', quality: 40 }, card: { geometry: "700x365>", format: 'jpg', quality: 40 },  thumbnail: { geometry: "320x167>", format: 'jpg', quality: 20 } }
  validates :name, presence: true
  validates :slug, uniqueness: true
  validates :url, presence: true
  before_create :slugify
  validates_attachment_content_type :cover_picture,
    content_type: /\Aimage\/.*\z/

  def slugify
    self.slug = self.name.to_slug.normalize.to_s
  end
end

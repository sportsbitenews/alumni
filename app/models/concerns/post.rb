module Post
  extend ActiveSupport::Concern

  POST_TYPES = %w(Resource Question)
  class UnauthorizedPostTypeException < Exception; end

  included do
    belongs_to :user
    validates :title, presence: true, length: { maximum: 255 }
    validates :user, presence: true
    acts_as_votable
    has_many :answers, as: :answerable

    # TODO(ssaunier): compute on-the-fly score for a resource
    # score = function(x is days passed since created_at, votes) {
    #  return votes / (1 + ln(x/2 + 1))
    # }
  end

  def mass_upvotes(count = 1)
    upvotes = 0
    (User.all - votes_for.voters).sample(count).each do |user|
      user.up_votes self
      upvotes += 1
    end
    upvotes
  end
end

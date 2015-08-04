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

  def add_upvotes(count = 1)
    upvotes = 0
    (User.all - votes_for.voters).sample(count).each do |user|
      user.up_voters self
      upvotes += 1
    end
    upvotes
  end

  def add_answers(count = 1)
    YAML.load_file(Rails.root.join('db/support/answers.yml')) .sample(count).each do |attributes|
      answer = answers.build attributes
      answer.user = User.random
      answer.save
    end
  end
end

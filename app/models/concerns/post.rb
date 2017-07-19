module Post
  extend ActiveSupport::Concern

  POST_TYPES = %w(Resource Question Job Milestone)
  PAGE_COUNT = 15
  class UnauthorizedPostTypeException < Exception; end

  included do
    searchkick index_name: 'post', callbacks: :async

    belongs_to :user
    validates :title, presence: true, length: { maximum: 255 }
    validates :user, presence: true
    acts_as_votable
    has_many :answers, as: :answerable

    scope :list, (lambda do |options = {}|
      page = options.fetch(:page, 1)
      order(created_at: :desc).page(page).limit(PAGE_COUNT).includes(:user)
    end)

    # TODO(ssaunier): compute on-the-fly score for a resource
    # score = function(x is days passed since created_at, votes) {
    #  return votes / (1 + ln(x/2 + 1))
    # }
  end

  def add_upvotes(count = 1)
    upvotes = 0
    (User.all - votes_for.voters).sample(count).each do |user|
      user.up_votes self
      upvotes += 1
    end
    upvotes
  end

  def add_answers(count = 1)
    YAML.load_file(Rails.root.join('db/support/answers.yml')).sample(count).each do |attributes|
      answer = answers.build attributes
      answer.user = User.random
      answer.save
    end
  end

  def search_data(data)
    data.merge("type" => self.class.to_s.underscore)
  end
end

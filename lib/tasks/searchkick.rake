namespace :searchkick do
  namespace :reindex do
    desc "Reindex all searchkick models"
    task all: :environment do
      (Resource.all + Job.all + Question.all + Milestone.all).each do |post|
        post.reindex
      end
    end
  end
end

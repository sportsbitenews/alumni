class AddUserToMilestones < ActiveRecord::Migration
  def change
    add_reference :milestones, :user, index: true, foreign_key: true
  end
end

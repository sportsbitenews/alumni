class AddStatusMoodLinkedInNicknameFacebookUsernamePreWagonExperiencesPostWagonExperiencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :mood, :text
    add_column :users, :linkedin_nickname, :string
    add_column :users, :facebook_nickname, :string
    add_column :users, :pre_wagon_experiences, :jsonb, array: true
    add_column :users, :post_wagon_experiences, :jsonb, array: true
  end
end

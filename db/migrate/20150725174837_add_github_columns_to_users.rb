class AddGithubColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, index: true
    add_column :users, :uid, :string, index: true
    add_column :users, :github_nickname, :string, index: true
    add_column :users, :gravatar_url, :string
    add_column :users, :name, :string
    add_column :users, :github_token, :string
  end
end

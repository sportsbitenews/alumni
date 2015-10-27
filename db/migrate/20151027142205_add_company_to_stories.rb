class AddCompanyToStories < ActiveRecord::Migration
  def change
    add_reference :stories, :company, index: true, foreign_key: true
  end
end

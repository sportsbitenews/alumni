class AddCourseLocaleToCity < ActiveRecord::Migration
  def change
    add_column :cities, :course_locale, :string
  end
end

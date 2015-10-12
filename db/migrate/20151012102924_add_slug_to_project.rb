class AddSlugToProject < ActiveRecord::Migration
  def change
    add_column :projects, :slug, :string, index: true
    Project.all.each do |project|
      project.slugify
      puts "#{project.id}: #{project.slug}"
      project.save!
    end
  end
end

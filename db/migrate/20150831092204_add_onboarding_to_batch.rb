class AddOnboardingToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :onboarding, :boolean
  end
end

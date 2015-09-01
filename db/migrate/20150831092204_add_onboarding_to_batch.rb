class AddOnboardingToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :onboarding, :boolean, default: false, null: false
  end
end

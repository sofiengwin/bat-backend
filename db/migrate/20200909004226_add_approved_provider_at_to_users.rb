class AddApprovedProviderAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :approved_provider_at, :datetime
  end
end

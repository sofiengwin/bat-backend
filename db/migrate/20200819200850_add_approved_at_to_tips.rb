class AddApprovedAtToTips < ActiveRecord::Migration[6.0]
  def change
    add_column :tips, :approved_at, :datetime
  end
end

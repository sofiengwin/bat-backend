class AddApprovedAtToAccumulations < ActiveRecord::Migration[6.0]
  def change
    add_column :accumulations, :approved_at, :datetime
  end
end

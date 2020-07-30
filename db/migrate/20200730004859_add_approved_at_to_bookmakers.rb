class AddApprovedAtToBookmakers < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmakers, :approved_at, :datetime
  end
end

class AddApprovedAtToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :approved_at, :datetime
  end
end

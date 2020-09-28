class RemoveTipIdFromPoints < ActiveRecord::Migration[6.0]
  def change
    remove_column :points, :tip_id, :bigint
  end
end

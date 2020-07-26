class AddMongoIdToTips < ActiveRecord::Migration[6.0]
  def change
    add_column :tips, :mongo_id, :integer
  end
end

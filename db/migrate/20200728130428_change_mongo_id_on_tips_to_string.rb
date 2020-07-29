class ChangeMongoIdOnTipsToString < ActiveRecord::Migration[6.0]
  def change
    change_column :tips, :mongo_id, :string
  end
end

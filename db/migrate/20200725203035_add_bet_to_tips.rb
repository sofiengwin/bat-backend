class AddBetToTips < ActiveRecord::Migration[6.0]
  def change
    add_column :tips, :bet, :string
  end
end

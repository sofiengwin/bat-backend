class AddBetCategoryToTips < ActiveRecord::Migration[6.1]
  def change
    add_column :tips, :bet_category, :string
  end
end

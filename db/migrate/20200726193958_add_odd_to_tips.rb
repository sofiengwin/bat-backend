class AddOddToTips < ActiveRecord::Migration[6.0]
  def change
    add_column :tips, :odd, :decimal, precision: 5, scale: 2
  end
end

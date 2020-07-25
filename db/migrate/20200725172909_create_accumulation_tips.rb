class CreateAccumulationTips < ActiveRecord::Migration[6.0]
  def change
    create_table :accumulation_tips do |t|
      t.references :tips, null: false, foreign_key: true
      t.references :accumulation, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateTips < ActiveRecord::Migration[6.0]
  def change
    create_table :tips do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.string :outcome
      t.string :body
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end

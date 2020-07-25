class CreateAccumulations < ActiveRecord::Migration[6.0]
  def change
    create_table :accumulations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end

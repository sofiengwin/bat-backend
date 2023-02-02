class CreateUserPointCounters < ActiveRecord::Migration[6.1]
  def change
    create_table :user_point_counters do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :awarded_at
      t.integer :point, default: 0

      t.timestamps
    end
  end
end

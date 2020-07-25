class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :home_team_name
      t.string :away_team_name
      t.string :score
      t.datetime :start_at
      t.integer :fixture_id
      t.string :league
      t.string :country

      t.timestamps
    end
  end
end

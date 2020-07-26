class AddFixtureIdIndexToMatches < ActiveRecord::Migration[6.0]
  def change
    add_index :matches, :fixture_id
  end
end

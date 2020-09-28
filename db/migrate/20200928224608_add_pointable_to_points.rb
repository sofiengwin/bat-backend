class AddPointableToPoints < ActiveRecord::Migration[6.0]
  def change
    add_reference :points, :pointable, polymorphic: true, null: false
  end
end
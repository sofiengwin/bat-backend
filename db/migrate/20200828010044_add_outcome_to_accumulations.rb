class AddOutcomeToAccumulations < ActiveRecord::Migration[6.0]
  def change
    add_column :accumulations, :outcome, :string, default: 'pending'
  end
end

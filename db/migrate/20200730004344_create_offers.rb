class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :link
      t.string :title
      t.string :description
      t.string :image_url
      t.string :subtitle

      t.timestamps
    end
  end
end

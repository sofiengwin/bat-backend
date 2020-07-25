class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :access_token
      t.string :token_id
      t.string :provider_id
      t.string :avatar_url

      t.timestamps
    end
  end
end

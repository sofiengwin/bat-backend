class AddPasswordDigestToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :password_digest, :string
  end
end

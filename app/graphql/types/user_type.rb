module Types
  class UserType < BaseObject
    field :id, String, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :username, String, null: false
    field :avatarUrl, String, null: true
  end 
end
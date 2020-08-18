module Types
  class AccumulationType < BaseObject
    field :id, ID, null: true
    field :tips, [TipType], null: false
    field :rating, Integer, null: true
    field :userName, String, null: false
    field :userId, String, null: false
    field :day, String, null: false

    def user_name
      object.user.name
    end

    def day
      object.created_at.strftime('%e %B')
    end
  end 
end
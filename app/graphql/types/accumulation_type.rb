module Types
  class AccumulationType < BaseObject
    field :id, ID, null: true
    association :tips, [TipType], null: false
    field :rating, Integer, null: true
    field :userName, String, null: false
    field :userId, String, null: false
    field :day, String, null: false

    def userName
      object.user.name
    end

    def userId
      object.user.id
    end

    def day
      object.created_at.strftime('%e %B')
    end
  end 
end
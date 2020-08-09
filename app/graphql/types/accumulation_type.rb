module Types
  class AccumulationType < BaseObject
    field :id, ID, null: true
    field :tips, [TipType], null: false
    field :rating, Integer, null: false
  end 
end
module Types
  class AccumulationType < BaseObject
    field :id, ID, required: false
    field :tips, [TipType], null: false
    field :rating, Integer, null: false
  end 
end
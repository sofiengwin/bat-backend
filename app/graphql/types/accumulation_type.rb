module Types
  class AccumulationType < BaseObject
    field :tips, [TipType], null: false
    field :rating, Integer, null: false
  end 
end
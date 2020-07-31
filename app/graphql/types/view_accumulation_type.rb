module Types
  class ViewAccumulationType < BaseObject
    field :accumulation, AccumulationType, null: false, hash_key: :accumulation
    field :availableTips, [TipType], null: true, hash_key: :availableTips
  end 
end
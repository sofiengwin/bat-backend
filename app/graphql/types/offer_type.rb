module Types
  class OfferType < BaseObject
    field :id, ID, null: false
    field :link, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :imageUrl, String, null: false
    field :subtitle, String, null: false
  end 
end
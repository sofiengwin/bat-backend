module Types
  class OfferType < BaseObject
    field :id, ID, null: false
    field :link, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :image_url, String, null: false
    field :subTitle, String, null: false
  end 
end
module Queries
  class FetchOffersQuery < BaseResolver
    type [Types::OfferType], null: false

    def resolve
      Offer.where.not(approved_at: nil)
    end
  end
end
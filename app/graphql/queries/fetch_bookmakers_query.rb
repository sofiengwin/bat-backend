module Queries
  class FetchBookmakersQuery < BaseResolver
    type [Types::OfferType], null: false

    def resolve
      Bookmaker.where.not(approved_at: nil)
    end
  end
end
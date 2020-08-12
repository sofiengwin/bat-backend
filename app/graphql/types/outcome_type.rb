module Types
  class OutcomeType < BaseEnum
    value(Tip::PENDING.upcase)
    value(Tip::WON.upcase)
    value(Tip::LOST.upcase)
  end
end
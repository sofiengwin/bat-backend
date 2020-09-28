class Point < ApplicationRecord
  belongs_to :pointable, polymorphic: true
  belongs_to :user
end

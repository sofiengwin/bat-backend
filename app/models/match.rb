class Match < ApplicationRecord
  has_many :tips, dependent: :destroy
end

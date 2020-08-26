class User < ApplicationRecord
  has_many :accumulations
  has_many :tips
end

class Period < ApplicationRecord
  has_ancestry
  has_many :products
end
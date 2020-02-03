class ChargeMethod < ApplicationRecord
  has_many :products
  has_ancestry
  accepts_nested_attributes_for :products
end

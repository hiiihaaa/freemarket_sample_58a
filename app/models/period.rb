class Period < ApplicationRecord
  has_ancestry
  has_many :products
  accepts_nested_attributes_for :products
end

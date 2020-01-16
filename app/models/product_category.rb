class ProductCategory < ApplicationRecord
  belongs_to :products ,optional: true
  has_many :categories
end

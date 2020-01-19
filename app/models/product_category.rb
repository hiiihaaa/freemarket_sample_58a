class ProductCategory < ApplicationRecord
  belongs_to :products ,optional: true
  belongs_to :categories,optional: true
end

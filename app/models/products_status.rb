class ProductsStatus < ApplicationRecord
  belongs_to :products ,optional: true
  has_many :statuses
end

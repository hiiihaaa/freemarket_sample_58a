class ProductSendArea < ApplicationRecord
  belongs_to :products ,optional: true
  has_many :send_areas
end

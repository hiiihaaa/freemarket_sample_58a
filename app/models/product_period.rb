class ProductPeriod < ApplicationRecord
  belongs_to :products ,optional: true
  has_many :periods
end

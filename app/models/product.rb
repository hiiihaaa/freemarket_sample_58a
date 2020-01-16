class Product < ApplicationRecord
  # belongs_to :user
  has_many_attached :images
  belongs_to :user
  has_one    :product_category
  accepts_nested_attributes_for :product_category
  has_one    :products_status
  accepts_nested_attributes_for :products_status
  has_one    :product_send_area
  accepts_nested_attributes_for :product_send_area
  has_one    :product_period
  accepts_nested_attributes_for :product_period
  has_one    :product_charge_method
  accepts_nested_attributes_for :product_charge_method
  # has_one    :product_brand
  # accepts_nested_attributes_for :product_brand
  has_one    :product_size
  accepts_nested_attributes_for :product_size
  has_one    :image
  accepts_nested_attributes_for :image

end

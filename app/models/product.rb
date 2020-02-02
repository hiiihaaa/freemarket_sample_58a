class Product < ApplicationRecord

  has_many   :comments

  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :period,   optional: true
  belongs_to :charge_method, foreign_key: 'product_id',optional: true



  # has_many :categories
  # has_one    :category
  # accepts_nested_attributes_for :category
  # has_one    :status
  # accepts_nested_attributes_for :status
  # has_one    :send_area
  # accepts_nested_attributes_for :send_area
  # has_one    :period
  # accepts_nested_attributes_for :period
  # has_one    :charge_method
  # accepts_nested_attributes_for :charge_method
  # has_one    :size
  # accepts_nested_attributes_for :size
  # has_one    :image
  # accepts_nested_attributes_for :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :address
  belongs_to_active_hash :status


end

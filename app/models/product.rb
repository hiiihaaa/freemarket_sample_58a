class Product < ApplicationRecord
  belongs_to :user
  has_many :product_images
  # has_many_attached :images
  # has_many :categories

  has_one    :category
  accepts_nested_attributes_for :category
  has_one    :status
  accepts_nested_attributes_for :status
  has_one    :send_area
  accepts_nested_attributes_for :send_area
  has_one    :period
  accepts_nested_attributes_for :period
  has_one    :charge_method
  accepts_nested_attributes_for :charge_method
  has_one    :size
  accepts_nested_attributes_for :size
  has_one    :image
  accepts_nested_attributes_for :image
  has_one    :address
  accepts_nested_attributes_for :address
  has_one    :sendmethod
  accepts_nested_attributes_for :sendmethod
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :address
  belongs_to_active_hash :status
  belongs_to_active_hash :period
  belongs_to_active_hash :size
  belongs_to_active_hash :sendmethod

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end
end

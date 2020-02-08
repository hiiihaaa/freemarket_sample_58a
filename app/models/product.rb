class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :period,   optional: true
  belongs_to :charge_method, optional: true

  has_many  :product_images
  accepts_nested_attributes_for :product_images

  belongs_to_active_hash :address
  belongs_to_active_hash :status
  belongs_to_active_hash :period
  belongs_to_active_hash :size

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end
end

class Product < ApplicationRecord
  # belongs_to :user
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :categories
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
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :address
  belongs_to_active_hash :status

  # belongs_to :user
  # has_many_attached :images
  # belongs_to :user
  # has_many :comments
  # has_many :categories

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
    # binding.pry
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end
end

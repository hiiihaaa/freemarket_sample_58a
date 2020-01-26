class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :categories

  def previous
    Product.where("id < ?", self.id).order("id DESC").first
    # binding.pry
  end
 
  def next
    Product.where("id > ?", self.id).order("id ASC").first
  end
end

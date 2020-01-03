class Product < ApplicationRecord
  # belongs_to :user
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :categories
end

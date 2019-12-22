class Product < ApplicationRecord
  validates  :name, presence: true
  validates  :detail, presence: true , length: { in: 1..100 }
  validates  :price, presence: true
  belongs_to :user
  belongs_to :category
  belongs_to :delivery
  has_many   :status
  mount_uploader :image1, ImageUploader
end

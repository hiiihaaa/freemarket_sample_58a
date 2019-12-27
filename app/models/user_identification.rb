class UserIdentification < ApplicationRecord
  number = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,100}+\z/i
  validates :user_id, presence: true
  validates :post_number, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :black, presence: true
  validates :telnumber, presence: true
end

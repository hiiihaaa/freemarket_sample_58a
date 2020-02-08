class User < ApplicationRecord
  has_one :phone
  accepts_nested_attributes_for :phone

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         number = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,100}+\z/i
         validates :password, presence: true,length: { minimum: 7 }  , format: { with: number }
         validates :lastname, presence: true
         validates :firstname, presence: true
         validates :firstname_kana, presence: true
         validates :lastname_kana, presence: true
         validates :birthday, presence: true
         validates :email, presence: true
end

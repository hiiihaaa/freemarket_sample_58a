class Phone < ApplicationRecord
  belongs_to :user
  validates :number, presence: true
  validates :comfirm_number, presence: true
end

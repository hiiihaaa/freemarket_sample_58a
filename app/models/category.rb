class Category < ApplicationRecord
<<<<<<< Updated upstream
  belongs_to :product
=======
  belongs_to :products ,optional: true
  # has_many :products, through: :products_categories
  has_ancestry
>>>>>>> Stashed changes
end

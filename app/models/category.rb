class Category < ApplicationRecord
  belongs_to :products ,optional: true
  has_ancestry
end

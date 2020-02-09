class TopController < ApplicationController
  def index
    @products = Product.limit(10)
    @ladies = Product.where(category_id: 1..207).limit(10)
    @mens = Product.where(category_id: 208..353)
    @electricals = Product.where(category_id: 903..988)
    @toys = Product.where(category_id: 690..802)
    # @ladies_image = ProductImage.find_by(product_id: @ladies)
    # @mens_image = ProductImage.find_by(product_id: @mens)
    # @electricals_image = ProductImage.find_by(product_id: @electricals)
    # @toys_image = ProductImage.find_by(product_id: @toys)
  end
end

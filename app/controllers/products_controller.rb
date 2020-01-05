class ProductsController < ApplicationController
  def index
    @product = Product.find(1)
    # @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
    @product_image = ProductImage.find_by(product_id: @product.id)
    @category = Category.find_by(product_id: @product.id)
    @product_user_other = Product.where(user_id: @product.user_id)
    @product_user_other_image = ProductImage.where(product_id: @product_user_other)
    @category_same = Category.where(name: @category.name)
    @other_product_image = ProductImage.where(product_id: @category_same)
    # @product_category_other = Product.where(id: @category_same[0])
    # @category_same.each do |product_id|
    #   @product_category_other = Product.where(id: @category_same[product_id])
    # end
    # @product_category_other = Product.where(id: @category_same[0].product_id)
    # @product_category_other = Product.where(id: @category_same.product_id)
  end

  def new
    @product = Product.new
    @product.users << current_user
  end

  def create
  end
end

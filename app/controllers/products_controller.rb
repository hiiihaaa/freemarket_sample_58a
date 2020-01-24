class ProductsController < ApplicationController
  def purchase
  end
  
  def index
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
    @product_image = ProductImage.find_by(product_id: @product.id)
    @category = Category.find_by(product_id: @product.id)
    @product_user_other = Product.where.not(id: @product.id).where(user_id: @product.user_id)
    @product_user_other_image = ProductImage.where(product_id: @product_user_other)
    @category_same = Category.where.not(product_id: @product.id).where(name: @category.name)
    @other_product_image = ProductImage.where(product_id: @category_same)
    # @next_and_back = 
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy if product.user_id == current_user.id
  end

  def new
    @product = Product.new
    @product.users << current_user
  end

  def create
  end
end

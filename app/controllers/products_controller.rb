class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy]

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
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
  end

  def new
    @product = Product.new
    10.times {@product.product_images.build}
  end

  def create
    @product = Product.new(product_params)
    @product.save!
    redirect_to root_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand, :price, :status_id, :category_id, :size_id, :status_id, :bearsize_id, :sendmethod_id, :address_id, :period_id, :charge_method_id, product_images_attributes: [:image_url]).merge(user_id: current_user.id)
  end
end

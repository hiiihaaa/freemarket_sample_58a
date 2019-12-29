class ProductsController < ApplicationController
  before_action :set_product
  def index
    @products = Product.find(params[:id])
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :size, :status, :shipping_fee, :shipping_method, :shipping_from, :shipping_date, :price, :brand, :purchase_status, images: [])
  end
end

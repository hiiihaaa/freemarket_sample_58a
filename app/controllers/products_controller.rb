class ProductsController < ApplicationController
  def purchase
  end
  
  def index
  end

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

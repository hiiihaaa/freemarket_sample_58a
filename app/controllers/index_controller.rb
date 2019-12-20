class IndexController < ApplicationController
  def index
    @products = Product.all
  end

  # private
  # def product_params
  #   params.permit(:name, :price)
  # end
  
  # def set_group
  #   @product = ProductImage.find(params[:product_id])
  # end
end

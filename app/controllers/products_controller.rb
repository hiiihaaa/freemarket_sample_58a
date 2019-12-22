class ProductsController < ApplicationController
  def index
    @product = Product.new
  end
  def show
    @product = Product.new(product_params)
  end

  private
  def product_params
    params.require(:product).permit(:name,:detail,:brand,:pricce,:image1,:image2,:image3,:image4,:image5,:image6,:image7,:image8,:image9,:image10)
  end
end

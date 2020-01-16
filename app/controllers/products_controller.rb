class ProductsController < ApplicationController

  def index
    @product = Product.new
    @category = Category.new
    @parents = Category.where(ancestry: nil)
    @charge_method_parents = ChargeMethod.where(ancestry: nil)
    @charge_method_children1 = ChargeMethod.find(1).children
    @charge_method_children2 = ChargeMethod.find(2).children
    @status = Status.all
    @sendarea = SendArea.all
    @period = Period.all

  end
  def new
    @product = Product.new
    @product.build_product_category
    @product.build_products_status
    @product.build_product_area
    @product.build_product_period
    @product.build_product_charge_method
    @product.build_product_size
    @product.build_image
  end
def create
  @product = Product.new(user_params)
  @product.criate
    binding.pry

  render "index"
end

  def cate_children
    @cate_children = Category.find(params[:parent]).children
  end
  def grand_children
    @grand_children = Category.find(params[:child_id]).children
  end
  private

def user_params
params.require(:product).permit(:id,:name,:detail,:brand,:price,:image,:status_id,
product_category_attributes:[:id,:categories_id],status_attributes:[:id],product_send_period_attributes:[:id],product_charge_method_attributes:[:id],product_size_attributes:[:id])
end
end


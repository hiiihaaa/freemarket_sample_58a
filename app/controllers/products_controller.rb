class ProductsController < ApplicationController
<<<<<<< HEAD
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
=======
  before_action :beforenew
  before_action :charge_method_children1, only: [:new, :create]
  before_action :charge_method_children2, only: [:new, :create]
  def index
    @product = Product.new
    @category = Category.new
    @parents = Category.where(ancestry: nil)
    @charge_method_parents = ChargeMethod.where(ancestry: nil)
    @status = Status.all
    @sendarea = Address.name
    @period = Period.all

>>>>>>> parent of 711faaf... Revert "Merge pull request #44 from hiiihaaa/WIP]商品出品ページ"
  end

  def new
    @product = Product.new
    @product.build_product_category
    @product.build_status
    @product.build_send_area
    @product.build_product_period
    @product.build_product_charge_method
    @product.build_product_size
    @product.build_image
  end
def create
  @product = Product.new(user_params)
  @product.save
  redirect_to root_path
end
def update
  @product = Product.new(user_params)
  @product.save
  redirect_to root_path
end

  def beforenew
    @charge_method_parents = ChargeMethod.where(ancestry: nil)
  end

  def cate_children
    @cate_children = Category.find(params[:parent]).children
  end
<<<<<<< HEAD

  private

  def set_product
    @product = Product.find(params[:id])
  end
=======
  def grand_children
    @grand_children = Category.find(params[:child_id]).children
  end
  def charge_method_children1
    @charge_method_children1 = ChargeMethod.find(1).children
  end
  def charge_method_children2
    @charge_method_children2 = ChargeMethod.find(2).children
  end

private
def user_params
  params.require(:product).permit(:id,:name,:description,:brand,:price,:status_id,:size,:category_id,:size_id,:status_id,:bearsize_id,:sendmethod_id,:address_id,:period_id)
end
>>>>>>> parent of 711faaf... Revert "Merge pull request #44 from hiiihaaa/WIP]商品出品ページ"
end


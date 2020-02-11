class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :destroy]

  def purchase
    @product = Product.find(params[:id])
    credit_card = CreditCard.where(user_id: current_user.id).first
    @product_image = ProductImage.where(product_id: @product.id)
    #登録された情報がない場合にカード登録画面に移動
    if credit_card.blank?
      redirect_to new_credit_card_path
    else
      #保管した顧客IDでpayjpから情報取得
      Payjp.api_key = "sk_test_0d9443b9a1a637b9456b6f24"
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      customer = Payjp::Customer.retrieve(credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(credit_card.card_id)
    end
  end
  def pay
    @product = Product.find(params[:id])
    credit_card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_0d9443b9a1a637b9456b6f24'
     payjp = Payjp::Charge.create(
    :amount => @product.price,            #支払金額
    # :card  => params['payjp-token'],
    :customer => credit_card.customer_id, #顧客ID
    :currency => 'jpy',                   #単位：日本円
    :description => '決済に関する説明'
    )
    @product.purchase_status = "2"
    @product.save
    redirect_to root_path
  end
  
  def index
    @q = Product.ransack(params[:q])
    @result = @q.result.page.page
  end

  def show
    @user = User.find(@product.user_id)
    @product_image = ProductImage.find_by(product_id: @product.id)
    @category = Category.find_by(id: @product.category_id)
    @product_user_other = Product.where.not(id: @product.id).where(user_id: @product.user_id)
    @product_user_other_image = ProductImage.where(product_id: @product_user_other)
    @charge_method = ChargeMethod.find_by(id: @product.bearsize_id)
    @charge_method2 = ChargeMethod.find_by(id: @product.sendmethod_id)
    @category_same = Product.where.not(id: @product.id).where(category_id: @product.category_id)
    @other_product_image = ProductImage.where(product_id: @category_same)
    @q = Product.ransack(params[:q])
    @result = @q.result(distinct: true)
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
    redirect_to root_path
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

  def search
    @q = Product.ransack(params[:q])
    @result = @q.result.page(params[:page]).per(132)
    render "top/search"
  end
  
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand, :price, :status_id, :category_id, :size_id, :status_id, :bearsize_id, :sendmethod_id, :address_id, :period_id, :charge_method_id, product_images_attributes: [:image_url]).merge(user_id: current_user.id)
  end
end

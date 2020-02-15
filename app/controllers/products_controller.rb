class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :search

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
    redirect_to product_path
  end
  
  def index
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
  end

  def destroy
    @product.destroy if @product.user_id == current_user.id
    redirect_to root_path
  end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
    @product.purchase_status = "1"

    respond_to do |format|
      if @product.save
        params[:product_images][:image].each do |image|
          @product.product_images.create(image_url: image, product_id: @product.id)
        end
        format.html{redirect_to root_path, notice: '商品を登録しました'}
      else
        @product.product_images.build
        format.html{render action: 'new'}
      end
    end
  end

  def edit
    gon.product = @product
    gon.product_images = @product.product_images

    #写真のデータをバイナリデータに
    require 'base64'
    require 'aws-sdk'
    gon.product_images_binary_datas =[]

    #本番環境と開発環境での場合分け
    if Rails.env.production?
      client = Aws::S3::Client.new(
        region: 'ap-northeast-1',
        access_key_id: Rails.application.credentials.aws[:access_key_id],
        secret_access_key: Rails.application.credentials.aws[:secret_access_key],
        )
      @product.product_images.each do |img|
        binary_data = client.get_object(bucket: 'freemarketsampleyakan58a', key: img.image_url.file.path).body.read
        gon.product_images_binary_datas << Base64.strict_encode64(binary_data)
      end

    else
      @product.product_images.each do |img|
        binary_data = File.read(img.image_url.file.file)
        gon.product_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
  end


  def update

    # 登録済画像のidの配列を生成
    ids = @product.product_images.map{|img| img.id }
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_image_params[:ids].map(&:to_i)
    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @product.update(product_edit_params)
      # 登録済画像のうち削除ボタンをおした画像を削除
      unless ids.length == exist_ids.length
        # 削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @product.product_images.find(id).destroy
        end
      end

      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |img|
          @product.product_images.create(image_url: img, product_id: @product.id)
        end
      end
      redirect_to root_path
      
      flash[:notice] = '編集が完了しました'
    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def search
    @q = Product.ransack(params[:q])

    @result = @q.result(distinct: true)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :brand, :price, :status_id, :category_id, :size_id, :status_id, :bearsize_id, :sendmethod_id, :address_id, :period_id, :charge_method_id, product_images_attributes: [:image_url]).merge(user_id: current_user.id)
  end
  def product_edit_params
    params.require(:product).permit(:name, :description, :brand, :price, :status_id, :category_id, :size_id, :status_id, :bearsize_id, :sendmethod_id, :address_id, :period_id, :charge_method_id).merge(user_id: current_user.id)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end
end

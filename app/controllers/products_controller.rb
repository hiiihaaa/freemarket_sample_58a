class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy, :update, :edit]

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
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
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

    gon.product_images_binary_datas =[]

    #本番環境と開発環境での場合分け
    if Rails.env.production?
      client = Aws::S3::Client.new(
        region: 'ap-northeast-1',
        access_key_id: Rails.application.credentials.aws[:access_key_id],
        secret_access_key: Rails.application.credentials.aws[:secret_access_key],
        )
      @product.product_images.each do |img|
        binary_data = client.get_object(bucket: '', key: img.image_url.file.path).body.read
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
      binding.pry
      redirect_to root_path and return
      

      flash[:notice] = '編集が完了しました'


    else
      flash[:alert] = '未入力項目があります'
      redirect_back(fallback_location: root_path)
    end

  end

  private
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

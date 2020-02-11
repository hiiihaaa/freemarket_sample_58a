class TopController < ApplicationController
  def index
    @products = Product.limit(10)
    @q = Product.ransack(params[:q])
    @result = @q.result(distinct: true)

    @ladies = Product.where(category_id: 1..207).limit(10)
    @mens = Product.where(category_id: 208..353).limit(10)
    @electricals = Product.where(category_id: 903..988).limit(10)
    @toys = Product.where(category_id: 690..802).limit(10)
  end
 
end

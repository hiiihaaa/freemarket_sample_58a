class TopController < ApplicationController
  def index
    @products = Product.limit(10)
    @q = Product.ransack(params[:q])
    @result = @q.result(distinct: true)

  end
 
end

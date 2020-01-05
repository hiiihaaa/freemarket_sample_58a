class TopController < ApplicationController
  skip_before_action :authenticate_user!, only:[:index, :show]
  def index
    @products = Product.limit(10)
  end
end

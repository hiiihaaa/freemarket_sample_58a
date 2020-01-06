class CommentsController < ApplicationController
  before_action :set_product

  def index
    @comment = Comment.new
    @comments = @product.comments.includes(:user)
  end

  def create
    @comment = @product.comments.new(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
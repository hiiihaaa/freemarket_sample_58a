class UsersController < ApplicationController
  before_action :move_to_signin
  before_action :search
  def move_to_signin
    redirect_to user_session_path unless user_signed_in?
  end
  def index
  end
  def show
    @user = User.find(params[:id])
    @user = current_user
    @user_identification = UserIdentification.find_by(user_id: @user.id)
  end
  def edit
    @user = User.find(params[:id])
  end
  def destroy
  end
  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      user.update_columns(user_params.to_hash)
      redirect_to edit_user_path(current_user.id)
    end
  end
  private
  def user_params
    params.require(:user).permit(:nickname,:profiles)
  end

  def search
    @q = Product.ransack(params[:q])
    @result = @q.result(distinct: true)
  end
end
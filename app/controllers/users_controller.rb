class UsersController < ApplicationController
  def new
  end
  def index
  end
  def show
    @user = current_user
  end
end
class UsersController < ApplicationController
  def new
  end
  def index
  end
  def destroy
  end
  def show
    redirect_to controller: 'devise/sessions', action: 'new'
  end
end
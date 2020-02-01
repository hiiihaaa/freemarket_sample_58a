class UsersController < ApplicationController
  def new
  end
  def index
  end
  def logout
  end
  def show
    redirect_to controller: 'devise/sessions', action: 'new'
  end
end
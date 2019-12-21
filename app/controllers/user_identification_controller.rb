class UserIdentificationController < ApplicationController
  def new
  end

  def create
    @user_identification = User_identification.new(
      post_number: params[:post_number],
      prefecture: params[:prefecture],
      city: params[:city],
      block: params[:block],
      building: params[:building]
    )
    @user_identification.save
  end

end

class UserIdentificationsController < ApplicationController
  def new
  end

  def create
    @user_identification = UserIdentification.new(
      post_number: params[:post_number],
      prefecture: params[:prefecture],
      city: params[:city],
      block: params[:block],
      building: params[:building],
      telnumber: params[:telnumber],
      users_id: params[:user_id]
    )

    if @user_identification.save
      redirect_to index_path
    end

  end

end

class CreditCardsController < ApplicationController
  
  require "payjp"

  def new
    @exp_month = ["--", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

    credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to action: "show" if credit_card.exists?
  end

  #payjpとCreditCardデータベース作成
  def pay 
    Payjp.api_key = "sk_test_0d9443b9a1a637b9456b6f24"
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit_card.save
        redirect_to action: "show"
      else
        recirect_to action: "pay"
      end
    end
  end
  
  def delete
    credit_card = CreditCard.where(user_id: current_user.id).first
    if credit_card.blank?
    else
      Payjp.api_key = "sk_test_0d9443b9a1a637b9456b6f24"
      customer = Payjp::Customer.retrieve(credit_card.customer_id)
      customer.delete
      credit_card.delete
    end
      redirect_to action: "new"
  end

  def show
    credit_card = CreditCard.where(user_id: current_user.id).first
    if credit_card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = "sk_test_0d9443b9a1a637b9456b6f24"
      customer = Payjp::Customer.retrieve(credit_card.customer_id)
      @default_card_info = customer.cards.retrieve(credit_card.card_id)
    end
  end
end


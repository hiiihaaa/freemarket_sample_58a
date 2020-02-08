crumb :root do
  link "メルカリ", root_path
end

crumb :product do
  product_name = Product.find(params[:id])
  link product_name.name, product_path
  parent :root
end

crumb :mypage do
  link "マイページ", users_path
  parent :root
end

crumb :credit do
  link "クレジットカード情報入力", new_credit_card_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", edit_user_path
  parent :mypage
end

crumb :identification do
  link "本人情報の確認", user_path
  parent :mypage
end
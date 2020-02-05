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

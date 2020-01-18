mothod1 = ChargeMethod.create!(layer:"送料込み(出品者負担)")
mothod2 = ChargeMethod.create!(layer:"着払い(購入者負担)")
mothod1.children.create([{layer:"未定"},{layer:"らくらくメルカリ便"},{layer:"ゆうメール"},{layer:"レターパック"},{layer:"普通郵便(定形、定形外)"},{layer:"クロネコヤマト"},{layer:"ゆうパック"},{layer:"クリックポスト"},{layer:"ゆうパケット"}])
mothod2.children.create([{layer:"未定"},{layer:"クロネコヤマト"},{layer:"ゆうパック"},{layer:"ゆうメール"}])




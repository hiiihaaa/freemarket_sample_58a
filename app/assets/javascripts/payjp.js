document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_c5dd5fa0cce328b8c51d5a7c")
      let btn = document.getElementById("token_submit"); 
      //発火
      btn.addEventListener("click", e => {
        e.preventDefault();
        let card = {
          number: document.getElementById("number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; 
        //入力されたデータを取得します。
        Payjp.createToken(card, (status, response) => {
          //成功した場合
          if (status === 200) { 
            //データを自サーバにpostしないように削除
            $("#number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            //取得したトークンを送信
            $(".registrationForm").get(0).submit();
            alert("登録が完了しました");
          } else {
            alert(response.error.message);
          }
        });
      });
    }
  },
  false
);
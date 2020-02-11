class SignupsController < ApplicationController
  before_action :authenticate_user!, only: :done
  
  def index
    delete_session # ユーザ登録を途中でやめたときのsessionを削除するために
      if user_signed_in?
      redirect_to root_path
      end
  end
  #omniauth_callbacks_controllerからリダイレクトされたアクション
 
  def step1
    #sns認証を使った場合とemaiのみの場合で処理を分ける
    if session[:provider]
      @user = User.new(
                    nickname: session[:nickname],
                    email: session[:email],
                    uid: session[:uid],
                    provider: session[:provider]
                  )
    else
      @user = User.new
    end
   end 

  def step1_validates
    params[:user][:birthday] = birthday_join # birthdayが通常のparameterでは拾ってこなので（２重ハッシュになっているuser=>"birthday(1i)",birthday(2i),birhday(3i)）、メソッドを設定して新しいdate型を返す バリデーションチェック前にsessionに入れる。バリテーション後だとNilで返ってくる。
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:firstname] = user_params[:firstname]
    session[:lastname] = user_params[:lastname]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:birthday] = params[:user][:birthday]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:user_params] = user_params #バリデーションチェック用
    @user = User.new(session[:user_params])
   

    # バリデーションチェック
    if @user.valid?
      redirect_to step2_signups_path and return
    else
      @user.errors.messages
      redirect_to step1_signups_path 
    end
  end

   def step2 #電話番号入力
     @user = User.new
     @user.build_phone
     @phone = Phone.new
   end

  def step3 #SMSの送信
    #twilioにて事前登録が必要(trialでの実装)
    #trialでの実装は、事前登録の電話番号にしかSMSが届かない設定になっている。
    @phone = user_params[:phone]#viewから送られてきた情報を受け取る

    phone_number = @phone[:number]#phoneナンバーだけの情報にする(user.idの情報も一緒に入っているため) 一緒に送るとエラーになる
    
    sms_number = "0001" #sms番号は統一している。
    session[:sms_number] = sms_number
    to_send_number = Rails.application.credentials.private_number[:REGISTRATION_NUMBER]
    client = Twilio::REST::Client.new(Rails.application.credentials.twilio[:TWILIO_ACCOUNT_SID],Rails.application.credentials.twilio[:TWILIO_AUTH_TOKEN])#credentials.ymlファイルにTWILIO_ACCOUNT_SIDとTWILIO_AUTH_TOKENの情報を記載している。秘匿情報なのでgitにはあげない。
      #生成した整数を文章にしたsms送信
      if phone_number == to_send_number #テスト環境下では登録したTEL番号にしか送信できないので、credentials.ymlにto_send_numberの電話番号を登録している。

        client.api.account.messages.create(from: Rails.application.credentials.twilio[:TWILIO_PHONE_NUMBER], to: phone_number ,body: sms_number)  #credentials.ymlファイルにTWILIO_PHONE_NUMBER(発信ナンバー)の情報を記載している。秘匿情報なのでgitにはあげない。
          redirect_to step4_new_phones_path  and return
      else
        redirect_to step3_signups_path
        @else =  '認証番号を入力してください' 
        return
      end
     @phone = Phone.new
     @user = User.new
  end

   def step4_new
      @phone = Phone.new
    end

  def step4 #認証コードのチェック
    @phone = comfirmnumber_params
    comfirm_number = @phone[:phone][:comfirm_number]

   # 認証コードのチェック実施。また、結果を受けてレンダリング先を決める
    if session[:sms_number]  == comfirm_number
      set_user_with_session
      if @user.save
        session[:id] = @user.id
        sign_in User.find(@user.id) unless user_signed_in?
        redirect_to user_identifications_new_path and return #本番環境ではここを変更する必要あり（アドレスへ繋げる）
      else
        redirect_to step4_new_phones_path
      end
    else
      @messages = '認証番号が一致しません'
    end
  end


  private
    def phonenumber_params
      phone = params.require(:user).permit(phone:[:number,:comfirm_number]) 
    end

    def comfirmnumber_params
      phone = params.permit(phone:[:comfirm_number])
    end


    def done; end

    def user_params
      params.require(:user).permit(:nickname, :email, :password, :lastname, :firstname,
                                  :lastname_kana, :firstname_kana, :birthday,:password_confirmation,:password_digest,
                                  phone: [:number, :comfirm_number])
    end

    def create_session
      session[:nickname] = user_params[:nickname]
      session[:email] = user_params[:email]
      # sns認証のときはsessionを使っている
      if session[:uid]
        else
        session[:password] = user_params[:password_confirmation]
        session[:password_confirmation] = user_params[:password_confirmation]
      end
      session[:lastname] = user_params[:lastname]
      session[:firstname] = user_params[:firstname]
      session[:lastname_kana] = user_params[:lastname_kana]
      session[:firstname_kana] = user_params[:firstname_kana]
      session[:birthday] = user_params[:birthday]
    end

    def set_user_with_session
      @user = User.new(
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password],
        lastname: session[:lastname],
        firstname: session[:firstname],
        lastname_kana: session[:lastname_kana],
        firstname_kana: session[:firstname_kana],
        birthday: session[:birthday],
        password_confirmation: session[:password_confirmation]
      )

    end



    def set_user_when_email(user_params)
      User.new(
            nickname: user_params[:nickname],
            email: user_params[:email],
            password: user_params[:password],
            lastname: user_params[:lastname],
            firstname: user_params[:firstname],
            birthday: user_params[:birthday],
            lastname_kana: user_params[:lastname_kana],
            firstname_kana: user_params[:firstname_kana]
       )
     end


    def delete_session
      session.delete(:nickname)
      session.delete(:email)
      session.delete(:password)
      session.delete(:password_confirmation)
      session.delete(:lastname)
      session.delete(:firstname)
      session.delete(:lastname_kana)
      session.delete(:firstname_kana)
      session.delete(:birthday)
      session.delete(:uid)
      session.delete(:provider)
    end
    
    def birthday_join
      # パラメーターで受け取ってくるのが、birthday(1i)birthday(2i)birthday(3i)の２重ハッシュとなるため、新たにdateを作り直す（birthdayカラムが一つのためこの作業が必要）
      date = params[:user]["birthday(1i)"],params[:user]["birthday(2i)"],params[:user]["birthday(3i)"]

      # ブランク時のエラー回避のため、ブランクだったら何もしない
      if date[0].blank? && date[1].blank? && date[2].blank?
        return
      else
        Date.new date[0].to_i,date[1].to_i,date[2].to_i
      # 年月日別々できたものを結合して新しいDate型変数を作って返す
      end
    end
end

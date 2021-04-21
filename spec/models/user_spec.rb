require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "新規登録/ユーザー情報" do
    context "新規登録/ユーザー情報ができるとき" do
      it "nickname,email,password,password_confirmation,lastname,firstname,lastname_kana,firstname_kana,bitrth_dateが存在すれば登録できる" do
       expect(@user).to be_valid 
      end

      it "passwordとpassword_confirmationが６文字以上で、半角英数字が混合されていれば登録できる" do
        @user.password = "000aaa"
        @user.password_confirmation= "000aaa"
        expect(@user).to be_valid
      end

    end

    context "新規登録/ユーザー情報ができない時" do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it "emailが空では登録できない" do
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it "passwordが空では登録できない" do
        @user.password = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation= ' '
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません" )
      end

      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "aaa111"
        @user.password_confirmation = "bbb222"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "重複したemailが存在する場合は登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it "passwordが５文字以下だと登録できない" do
        @user.password = "aa111"
        @user.password_confirmation = "aa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end 

      it "メールアドレスに@が含まれていないと登録できない" do
        @user.email = "aaaa.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end

      it "パスワードは英語のみでは登録できないこと" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを6文字以上の半角英数字で入力してください")
      end

      it "パスワードは数字のみでは登録できないこと" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを6文字以上の半角英数字で入力してください")
      end

      it "パスワードは全角では登録できないこと" do
        @user.password = "ああああああ"
        @user.password_confirmation = "ああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを6文字以上の半角英数字で入力してください")
      end
    end
  end

  describe "新規登録/本人情報確認" do
    context "新規登録/本人情報確認ができない時" do
      it "lastnameが空では登録でない " do
        @user.lastname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end

      it "firstnameが空では登録でない " do
        @user.firstname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end

      it "lastname_kanaが空では登録でない " do
        @user.lastname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カタカナ）を入力してください")
      end

      it "firstname_kanaが空では登録でない " do
        @user.firstname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カタカナ）を入力してください")
      end

      it "bitrth_dateが空では登録できない" do
        @user.bitrth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      it "lastnameは全角（漢字ひらがなカタカナ）でないと登録できない" do
        @user.lastname = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を全角で入力してください")
      end

      it "firstnameは全角（漢字ひらがなカタカナ）でないと登録できない" do
        @user.firstname = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("名を全角で入力してください")
      end

      it "lastname_kanaは全角カタカナでないと登録できない" do
        @user.lastname_kana = "あああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カタカナ）を全角カタカナで入力してください")
      end

      it "firstname_kanaは全角カタカナでないと登録できない" do
        @user.firstname_kana = "あああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カタカナ）を全角カタカナで入力してください")
      end      
    end
  end

end

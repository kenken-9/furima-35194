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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "passwordが空では登録できない" do
        @user.password = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation= ' '
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password" 
      end

      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "aaa111"
        @user.password_confirmation = "bbb222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "重複したemailが存在する場合は登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it "passwordが５文字以下だと登録できない" do
        @user.password = "aa111"
        @user.password_confirmation = "aa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end 

      it "メールアドレスに@が含まれていないと登録できない" do
        @user.email = "aaaa.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードは英語のみでは登録できないこと" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it "パスワードは数字のみでは登録できないこと" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it "パスワードは全角では登録できないこと" do
        @user.password = "ああああああ"
        @user.password_confirmation = "ああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
    end
  end

  describe "新規登録/本人情報確認" do
    context "新規登録/本人情報確認ができない時" do
      it "lastnameが空では登録でない " do
        @user.lastname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname can't be blank")
      end

      it "firstnameが空では登録でない " do
        @user.firstname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end

      it "lastname_kanaが空では登録でない " do
        @user.lastname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
      end

      it "firstname_kanaが空では登録でない " do
        @user.firstname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end

      it "bitrth_dateが空では登録できない" do
        @user.bitrth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Bitrth date can't be blank")
      end

      it "lastnameは全角（漢字ひらがなカタカナ）でないと登録できない" do
        @user.lastname = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname Full-width characters")
      end

      it "firstnameは全角（漢字ひらがなカタカナ）でないと登録できない" do
        @user.firstname = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname Full-width characters")
      end

      it "lastname_kanaは全角カタカナでないと登録できない" do
        @user.lastname_kana = "あああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana Full-width katakana characters")
      end

      it "firstname_kanaは全角カタカナでないと登録できない" do
        @user.firstname_kana = "あああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana Full-width katakana characters")
      end      
    end
  end

end

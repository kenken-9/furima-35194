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

    end
  end

end

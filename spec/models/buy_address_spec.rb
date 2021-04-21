require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  describe "配送先入力情報保存" do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @buy_address = FactoryBot.build(:buy_address, user_id: user.id , product_id: product.id)
      # サーバーに負荷がかかっている為記載
       sleep 0.1 
       # / サーバーに負荷がかかっている為記載
    end

      context "入力情報に問題が無い場合" do
        it "全ての情報が正しく入力されている" do
          expect(@buy_address).to be_valid
        end

        it "建物名がなくても登録できる" do
          @buy_address.building_name = ""
          expect(@buy_address).to be_valid
        end
      end

      context "入力情報に問題がある場合" do
        it "郵便番号が空では登録できない" do
          @buy_address.postal_code = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("郵便番号を入力してください")
        end

        it "市区町村が空では登録できない" do
          @buy_address.municipality = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("市区町村を入力してください")
        end

        it "番地が空では登録できない" do
          @buy_address.block_number = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("番地を入力してください")
        end

        it "電話番号が空では登録できない" do
          @buy_address.phone_number = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("電話番号を入力してください")
        end
       
        it "都道府県をを選択しないと登録できない" do
          @buy_address.area_id = 1
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("都道府県を選択してください")
        end

        it "郵便番号の保存にはハイフンが必要であること" do
          @buy_address.postal_code = "1111111"
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("郵便番号をハイフンを含めた半角数字で入力してください")
        end

        it "電話番号は11桁以内の数値のみ保存可能なこと" do
          @buy_address.phone_number = "111111111111111111"
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("電話番号を11桁以内の半角数字で入力してください")
        end

        it "tokenが空では送信できない" do
          @buy_address.token = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("クレジットカード情報を入力してください")
        end

        it "user_idが空では送信できない" do
          @buy_address.user_id = nil
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include( "Userを入力してください")
        end

        it "product_idが空では送信できない" do
          @buy_address.product_id = nil
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include( "Productを入力してください")
        end

        it "電話番号は英数字混合では登録できない" do
          @buy_address.phone_number = "11111aaaaaa" 
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include( "電話番号を11桁以内の半角数字で入力してください")
        end

      end
  end
end

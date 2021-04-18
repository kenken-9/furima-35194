require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  describe "配送先入力情報保存" do
    before do
      @buy_address = FactoryBot.build(:buy_address)
    end

      context "入力情報に問題が無い場合" do
        it "全ての情報が正しく入力されている" do
          expect(@buy_address).to be_valid
        end
      end

      context "入力情報に問題がある場合" do
        it "郵便番号が空では登録できない" do
          @buy_address.postal_code = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Postal code can't be blank")
        end

        it "市区町村が空では登録できない" do
          @buy_address.municipality = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Municipality can't be blank")
        end

        it "番地が空では登録できない" do
          @buy_address.block_number = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Block number can't be blank")
        end

        it "電話番号が空では登録できない" do
          @buy_address.block_number = ""
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Block number can't be blank")
        end
       
        it "都道府県をを選択しないと登録できない" do
          @buy_address.area_id = 1
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Area Select")
        end

        it "郵便番号の保存にはハイフンが必要であること" do
          @buy_address.postal_code = "1111111"
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Postal code code Input correctly")
        end

        it "電話番号は11桁以内の数値のみ保存可能なこと" do
          @buy_address.postal_code = "111111111111111111"
          @buy_address.valid?
          expect(@buy_address.errors.full_messages).to include("Postal code code Input correctly")
        end
      end


  end
end

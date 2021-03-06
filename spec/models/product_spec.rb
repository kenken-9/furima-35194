require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)

  end

  describe "商品出品機能" do

    context "商品出品ができる時" do
      it "name,text,price,user_id,category_id,condition_id,fee_id,area_id,ship_idがあれば登録できる" do
        expect(@product).to be_valid 
      end

      it "販売価格は半角数字のみ登録ができる" do
        @product.price = "300"
        expect(@product).to be_valid 
      end
    end

    context "商品出品ができない時" do
      it "商品画像が空では登録できない" do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("画像を入力してください")
      end

      it "商品名が空では登録できない" do
        @product.name = ""
        @product.valid?
        expect(@product.errors.full_messages).to include("商品名を入力してください")
      end

      it "商品の説明が空では登録できない" do
        @product.text = ""
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の説明を入力してください")
      end

      it "カテゴリーを選択しないと登録できない" do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it "商品の状態を選択しないと登録できない" do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("商品の状態を選択してください")
      end

      it "発送料の負担を選択しないと登録できない" do
        @product.fee_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("発送料の負担を選択してください")
      end

      it "発送元の地域を選択しないと登録できない" do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it "発送までの日数を選択しないと登録できない" do
        @product.ship_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it "販売価格が空では登録できない" do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("価格を入力してください")
      end

      it "販売価格は299円以下では登録できない" do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("価格を設定範囲内で入力してください")
      end

      it "販売価格は10,000,000円以上では登録できない" do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include("価格を設定範囲内で入力してください")
      end
    end
  end
end

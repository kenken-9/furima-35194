class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_one :buy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :fee
  belongs_to :area
  belongs_to :ship

  with_options presence: true do
    validates :image
    validates :name
    validates :text
    validates :price, format: { with: /\A[0-9]+\z/, message: "を半角数字で入力してください" }, inclusion: { in: 300..9999999, message: "を設定範囲内で入力してください" }
  end

  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :fee_id
    validates :area_id
    validates :ship_id
  end
end

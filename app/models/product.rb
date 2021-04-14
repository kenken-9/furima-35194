class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :user

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
    validates :price, format: { with: /\A[0-9]+\z/, message: "Half-width number" }, inclusion: { in: 300..9999999, message: "Out of setting range" }
  end

  with_options numericality: { other_than: 1, message: "Select" } do
    validates :category_id
    validates :condition_id
    validates :fee_id
    validates :area_id
    validates :ship_id
  end
end

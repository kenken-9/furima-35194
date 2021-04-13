class Product < ApplicationRecord
    has_one_attached :image

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
        validates :price, inclusion: { in: 300..9999999,message: "Out of setting range"} , format: { with: /\A[0-9]+\z/ , message: "Half-width number" }
    end

    validates :category_id, numericality:  {other_than: 1 ,message: "Select"}
    validates :condition_id, numericality: {other_than: 1 ,message: "Select"}
    validates :fee_id, numericality: {other_than: 1 ,message: "Select"}
    validates :area_id, numericality: {other_than: 1 ,message: "Select"}
    validates :ship_id, numericality: {other_than: 1 ,message: "Select"}

end

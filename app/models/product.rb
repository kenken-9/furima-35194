class Product < ApplicationRecord
    has_one_attaced :image

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
    end

    validates :category_id, numericality: { other_than: 1 }
    validates :condition_id, numericality: { other_than: 1 }
    validates :fee_id, numericality: { other_than: 1 }
    validates :area_id, numericality: { other_than: 1 }
    validates :ship_id, numericality: { other_than: 1 }



end

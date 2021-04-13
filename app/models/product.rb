class Product < ApplicationRecord
    has_one_attaced :image

    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category, :condition, :fee, :area, :ship
end

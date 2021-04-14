class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products

  with_options presence: true do
    validates :password, format: {with:/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message:"Include both letters and numbers" }
    validates :nickname
    with_options  format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Full-width characters' } do
      validates :lastname
      validates :firstname
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/  , message: "Full-width katakana characters"  } do
      validates :lastname_kana
      validates :firstname_kana
    end
    validates :bitrth_date 
  end

end

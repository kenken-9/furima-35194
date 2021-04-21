class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :buys


  with_options presence: true do
    validates :password, format: {with:/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message:"を6文字以上の半角英数字で入力してください" }
    validates :nickname
    with_options  format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'を全角で入力してください' } do
      validates :lastname
      validates :firstname
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/  , message: "を全角カタカナで入力してください"  } do
      validates :lastname_kana
      validates :firstname_kana
    end
    validates :bitrth_date 
  end

end

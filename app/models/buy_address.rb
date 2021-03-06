class BuyAddress
     include ActiveModel::Model
    attr_accessor :user_id, :product_id, :postal_code, :area_id, :municipality, :block_number, :building_name, :phone_number,  :token

    with_options presence:true do
      validates :product_id
      validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "をハイフンを含めた半角数字で入力してください"}
      validates :municipality
      validates :block_number
      validates :phone_number, format: {with: /\A\d{11}\z/ , message: "を11桁以内の半角数字で入力してください"}
      validates :token
      validates :user_id
    end
    validates :area_id, numericality: { other_than: 1, message: "を選択してください" }

    def save
      buy = Buy.create(user_id: user_id, product_id: product_id)
      Address.create(postal_code: postal_code, area_id: area_id, municipality: municipality, block_number: block_number, building_name: building_name, phone_number: phone_number, buy_id: buy.id )
    end
end
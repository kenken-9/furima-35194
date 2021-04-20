FactoryBot.define do
  factory :buy_address do
    postal_code {"111-0000"}
    area_id { 2 }
    municipality {"市区町村"}
    block_number {"番地"}
    building_name{ "建物名"}
    phone_number{"11111111111"}
    user_id {"1"}
    product_id {"1"}
    token {"tok_abcdefghijk00000000000000000"}
    price {99999}
  end
end

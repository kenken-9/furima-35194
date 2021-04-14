FactoryBot.define do
  factory :product do
    name { Faker::Team.name }
    text { Faker::Lorem.sentence }
    price { 99999 }
    category_id { 2 }
    condition_id { 2 }
    fee_id { 2 }
    area_id { 2 }
    ship_id { 2 }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open("public/images/test_image.png"), filename: "test_image.png")
    end
  end
end

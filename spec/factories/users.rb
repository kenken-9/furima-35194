FactoryBot.define do
    factory :user do
        nickname              {Faker::Name.initials(number: 2)}
        email                 {Faker::Internet.free_email}
        password              {Faker::Internet.password(min_length: 6)}
        password_confirmation {password}
        lastname {"ぜんかく"}
        firstname{"ぜんかく"}
        lastname_kana{"ゼンカクカナ"}
        firstname{"ゼンカクカナ"}
        bitrth_date{"1930-01-01"}
    end
  end
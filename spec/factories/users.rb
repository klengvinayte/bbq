FactoryBot.define do
  factory :user do
    name { "User#{rand(999)}" }
    email { "user#{rand(999)}@user.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456" }
  end
end

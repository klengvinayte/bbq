FactoryBot.define do
  factory :event do
    title { "Event" }
    description { "Description" }
    address { "Vilnius" }
    datetime { "#{rand(1..31)} Dec #{rand(2023..2025)} 10:00:00" }
  end
end

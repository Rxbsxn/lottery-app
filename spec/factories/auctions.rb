FactoryGirl.define do
  factory :auction do
    name { FFaker::Product.product_name }
    content { FFaker::Lorem.paragraphs.join("\n") }
  end
end

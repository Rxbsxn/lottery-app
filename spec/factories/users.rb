FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'topsecret' }
    password_confirmation { password }

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end

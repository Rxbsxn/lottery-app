FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email}
    password { 'topsecret'}
    password_confirmation { password }

  end
end

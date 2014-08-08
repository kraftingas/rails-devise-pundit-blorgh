FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end
    
    trait :user do
      role 'user'
    end
    
    trait :vip do
      role 'vip'
    end

  end
end

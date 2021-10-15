FactoryBot.define do
  factory :user do
    email { "#{SecureRandom.hex(3)}@gmail.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

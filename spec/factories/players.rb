FactoryBot.define do
  factory :player do
    name { 'name' }
    details { 'details' }
    uuid  { SecureRandom.uuid }
    association :team, factory: :team
  end
end

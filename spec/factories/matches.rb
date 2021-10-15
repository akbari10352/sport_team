FactoryBot.define do
  factory :match do
    date { 2.days.from_now.to_date }
    name { 'name' }
    description { 'desc' }
    uuid { SecureRandom.uuid }
  end
end

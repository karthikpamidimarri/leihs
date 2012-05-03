FactoryGirl.define do

  factory :model do
    name { Faker::Name.name }
    manufacturer { Faker::Name.name }
    description { Faker::Lorem.sentence }
    internal_description { Faker::Lorem.sentence }
    maintenance_period { rand(4) }
    is_package false
    technical_detail { Faker::Lorem.sentence }
    hand_over_note { Faker::Lorem.sentence }
    
    factory :model_with_items do
      ignore do
        inventory_pool { FactoryGirl.create :inventory_pool }
      end
      after_create do |model, evaluator|
        3.times do
          model.items << FactoryGirl.create(:item, :inventory_pool => evaluator.inventory_pool)
        end
      end
    end
    
  end

end
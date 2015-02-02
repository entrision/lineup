FactoryGirl.define do
  factory :lineup_position do
    position 1
    player
    player_lineup
  end
end

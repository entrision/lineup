class PlayerLineup < ActiveRecord::Base
  belongs_to :coach
  has_many   :players, through: :lineup_positions
end

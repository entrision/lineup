class LineupPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :player_lineup

  # validation for changing lineup position
  # - win % must be greater than the player being overtaken in the lineup
end

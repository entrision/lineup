class LineupPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :player_lineup

  validates_uniqueness_of :player_id, scope: :player_lineup
  #validates_uniqueness_of :position, scope: :player_lineup_id

  default_scope { order('position') }

  # validation for changing lineup position
  # - win % must be greater than the player being overtaken in the lineup
end

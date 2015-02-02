class LineupPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :player_lineup

  validates_presence_of :player, :player_lineup
  validates_uniqueness_of :player_id, scope: :player_lineup
  validates_with LineupPositionValidator, on: :update, if: :validation_needed?

  default_scope { order('position') }

  def new_position?
    (self.position_changed?) ? true : false
  end

  def validation_needed?
    # players have played at least 1 match, and the position has changed
    (self.player.matches_played >= 1 && new_position?) ? true : false
  end
end

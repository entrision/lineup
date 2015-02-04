class LineupPosition < ActiveRecord::Base
  belongs_to :player
  belongs_to :player_lineup

  before_save :set_move_restrictions
  before_save :set_match_count_at_change
  validates_presence_of :player
  validates_uniqueness_of :player_id, scope: :player_lineup
  validates_with LineupMovementValidator, on: :update, if: :movement_validation_needed?

  default_scope { order('position') }

  def movement_validation_needed?
    # players have played at least 1 match, and the position has changed
    (self.player.matches_played >= 1 && self.position_changed?) ? true : false
  end

  private
    def set_move_restrictions
      if self.player.matches_played > 5
        self.restrict_movement = true
      end
    end

    def set_match_count_at_change
      if self.position_changed?
        self.player_match_count_at_change = self.player.matches_played
      end
    end
end

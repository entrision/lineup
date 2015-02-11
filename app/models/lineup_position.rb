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

  def locked?
    match_difference = self.player.matches_played - self.player_match_count_at_change
    if self.restrict_movement && (match_difference < 3)
      true
    else
      false
    end
  end

  def check_and_move_mandatory
    unless self.locked?
      if mandatory_move_required?
        mandatory_move!
      end
    end
  end

  def can_move_up?
    if position_above && matches_played?
      position_above.player.win_percentage < self.player.win_percentage ? true : false
    elsif !matches_played?
      true
    else
      false # no position to move to
    end
  end

  def can_move_down?
    if position_below && matches_played?
      position_below.player.win_percentage > self.player.win_percentage ? true : false
    elsif !matches_played?
      true
    else
      false
    end
  end

  def matches_played?
    self.player.matches_played > 0 ? true : false
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

    def position_below
      if self.position
        LineupPosition.where(player_lineup: self.player_lineup, position: self.position+1).first
      end
    end

    def position_above
      if self.position
        LineupPosition.where(player_lineup: self.player_lineup, position: self.position-1).first
      end
    end

    def mandatory_move!
      spot_below = position_below
      new_position = spot_below.position
      spot_below.position = self.position
      self.position = new_position

      spot_below.save
      self.save
    end

    def win_percentage_differential(position)
      position.player.win_percentage - self.player.win_percentage
    end

    def mandatory_move_required?
      if position_below && (self.player.matches_played > 5)
        differential = win_percentage_differential(position_below)
        differential > 0.20 ? true : false
      else
        false
      end
    end

end

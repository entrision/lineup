class ExtendedMovementValidator < ActiveModel::Validator

  # must place 3 matches at position
  def validate(record)
    unless position_shift_wait_observed?(record)
      record.errors[:position] << "must play at least 3 matches at position"
    end
  end

  def position_shift_wait_observed?(record)
    games = record.player.matches_played - record.player_match_count_at_change
    !(record.restrict_movement && games < 3)
  end

end

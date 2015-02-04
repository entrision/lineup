class LineupMovementValidator < ActiveModel::Validator
  def validate(record)
    unless moved_by_one?(record) # only move 1 position at a time
      record.errors[:position] << "cannot move more than one position"
    end

    unless win_rules_followed?(record)
      record.errors[:position] << "can't move unless win percentage complies"
    end

    unless match_played_since_move?(record)
      record.errors[:position] << "must play a match before moving again"
    end

    unless position_shift_wait_observed?(record)
      record.errors[:position] << "must play at least 3 matches at position"
    end
  end

  def win_rules_followed?(record)
    unless overtaking_position?(record) # win rules always followed
      return true
    end

    p1 = Player.joins(:lineup_positions).where(
        lineup_positions: { position: record.position, player_lineup: record.player_lineup }
    ).first
    p2 = record.player

    if moving_up?(record)
      (p2.win_percentage > p1.win_percentage) ? true : false
    else
      (p1.win_percentage > p2.win_percentage) ? true : false
    end
  end

  def moved_by_one?(record)
    ( (record.position - record.position_was).abs <= 1 ) ? true : false
  end

  def match_played_since_move?(record)
    (record.player.matches_played > record.player_match_count_at_change) ? true : false
  end

  def overtaking_position?(record)
    (LineupPosition.where(position: record.position, player_lineup: record.player_lineup).any?) ? true : false
  end

  def moving_up?(record)
    (record.position < record.position_was) ? true : false
  end

  def position_shift_wait_observed?(record)
    games = record.player.matches_played - record.player_match_count_at_change
    (record.restrict_movement && games < 3) ? false : true
  end
end

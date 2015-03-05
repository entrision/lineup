class BaseMovementValidator < ActiveModel::Validator

  # validates match has been played
  # validates win %
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
  end

  def win_rules_followed?(record)
    return true if !overtaking_position?(record)

    p1 = Player.joins(:lineup_positions).where(
        lineup_positions: { position: record.position, player_lineup: record.player_lineup }
    ).first

    p2 = record.player

    if moving_up?(record)
      return p2.win_percentage > p1.win_percentage
    else
      return p1.win_percentage > p2.win_percentage
    end
  end

  def moved_by_one?(record)
    (record.position - record.position_was).abs <= 1
  end

  def match_played_since_move?(record)
    record.player.matches_played > record.player_match_count_at_change
  end

  def overtaking_position?(record)
    LineupPosition.where(position: record.position, player_lineup: record.player_lineup).any?
  end

  def moving_up?(record)
    record.position < record.position_was
  end
end

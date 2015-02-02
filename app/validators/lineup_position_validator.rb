class LineupPositionValidator < ActiveModel::Validator
  def validate(record)
    unless within_movement_restrictions?(record)
      record.errors[:position] << "can't move more than 1"
    end

    if overtaking_position?(record)
      result = win_rules_followed?(record)
      if !result
        record.errors[:position] << "can't move unless win percentage complies"
      end
    end
  end

  def within_movement_restrictions?(record)
    if (record.position - record.position_was).abs <= 1
      true
    else
      false
    end
  end

  def win_rules_followed?(record)
    p1 = Player.joins(:lineup_positions).where(
        lineup_positions: { position: record.position, player_lineup: record.player_lineup }
    ).first
    p2 = Player.find(record.player)

    if moving_up?(record)
      (p2.win_percentage > p1.win_percentage) ? true : false
    else
      (p1.win_percentage > p2.win_percentage) ? true : false
    end
  end

  def overtaking_position?(record)
    if LineupPosition.where(position: record.position, player_lineup: record.player_lineup).any?
      true
    else
      false
    end
  end

  def moving_up?(record)
    if record.position < record.position_was
      true
    else
      false
    end
  end

end

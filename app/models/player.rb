class Player < ActiveRecord::Base

  has_many   :player_lineups, through: :lineup_positions
  has_many   :lineup_positions

  belongs_to :coach

  validates :name, :coach, presence: true

  def matches_played
    [win, loss].sum
  end

  def matches_played?
    matches_played > 0
  end

  def win_percentage
    return nil if matches_played.zero?
    win.fdiv(matches_played).round(3)
  end

  def win_loss=(value)
    value > 0 ? self.win += value : self.loss += 1
  end

  def win_loss
    1
  end

end

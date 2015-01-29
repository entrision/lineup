class Player < ActiveRecord::Base
  has_many   :player_lineups, through: :lineup_positions
  has_many   :lineup_positions
  belongs_to :coach

  validates_presence_of :name

  def matches_played
    self.win + self.loss
  end

  def win_percentage
    if self.matches_played.zero?
      nil
    else
      self.win.fdiv(self.matches_played).round(3)
    end
  end

  def win_loss=(value)
    if value.to_i == 1
      self.win += 1
    else
      self.loss += 1
    end
  end

  def win_loss
    1
  end
end

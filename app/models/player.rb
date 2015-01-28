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
end

class Player < ActiveRecord::Base
  has_many :player_lineups, through: :lineup_positions

  # matches played
  # win %
end

class PlayerLineup < ActiveRecord::Base

  belongs_to :coach

  has_many   :players, through: :lineup_positions
  has_many   :lineup_positions, dependent: :destroy

  accepts_nested_attributes_for :lineup_positions, allow_destroy: true
  validates_associated :lineup_positions

  validates :title, presence: true

end

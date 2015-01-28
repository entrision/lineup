require 'rails_helper'

RSpec.describe Player, type: :model do
  subject(:player) { Player.new(name: "Guy Testman", win: 10, loss: 1) }

  context "when not valid" do
    it "missing name" do
      player.name = ''
      expect(player).to be_invalid
    end
  end

  context "when valid" do
    it "calculates total matches" do
      expect(player.matches_played).to eq(11)
    end

    it "calculates win percentage" do
      expect(player.win_percentage).to eq(0.909)
    end

  end
end
